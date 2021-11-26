#!/usr/bin/env python
# encoding: utf-8
#
# https://github.com/munki/macadmin-scripts/blob/master/installinstallmacos.py
#
# Copyright 2017 Greg Neagle.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Thanks to Tim Sutton for ideas, suggestions, and sample code.
#
# Updated in May of 2019 by Dhiru Kholia.

'''installinstallmacos.py
A tool to download the parts for an Install macOS app from Apple's
softwareupdate servers and install a functioning Install macOS app onto an
empty disk image'''

# https://github.com/foxlet/macOS-Simple-KVM/blob/master/tools/FetchMacOS/fetch-macos.py
# is pretty similar.


# Bad hack
import warnings

warnings.filterwarnings("ignore", category=DeprecationWarning)

import os
import gzip
import argparse
import plistlib
import subprocess

from xml.dom import minidom
from xml.parsers.expat import ExpatError


import sys

if sys.version_info[0] < 3:
    import urlparse as urlstuff
else:
    import urllib.parse as urlstuff

# https://github.com/foxlet/macOS-Simple-KVM/blob/master/tools/FetchMacOS/fetch-macos.py (unused)
catalogs = {
    "CustomerSeed": "https://swscan.apple.com/content/catalogs/others/index-10.16customerseed-10.16-10.15-10.14-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog",
    "DeveloperSeed": "https://swscan.apple.com/content/catalogs/others/index-10.16seed-10.16-10.15-10.14-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog",
    "PublicSeed": "https://swscan.apple.com/content/catalogs/others/index-10.16beta-10.16-10.15-10.14-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog",
    "PublicRelease": "https://swscan.apple.com/content/catalogs/others/index-10.16-10.15-10.14-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog"
}


def get_default_catalog():
    '''Returns the default softwareupdate catalog for the current OS'''
    # return catalogs["PublicRelease"]
    return catalogs["DeveloperSeed"]


class ReplicationError(Exception):
    '''A custom error when replication fails'''
    pass


def cmd_exists(cmd):
    return subprocess.call("type " + cmd, shell=True,
                           stdout=subprocess.PIPE, stderr=subprocess.PIPE) == 0


def replicate_url(full_url,
                  root_dir='/tmp',
                  show_progress=False,
                  ignore_cache=False,
                  attempt_resume=False, installer=False, one_more_hack=False):
    '''Downloads a URL and stores it in the same relative path on our
    filesystem. Returns a path to the replicated file.'''

    # hack
    print("[+] Fetching %s" % full_url)
    if installer and "BaseSystem.dmg" not in full_url and not one_more_hack:
        return
    attempt_resume = True
    # path = urllib.parse.urlsplit(full_url)[2]
    path = urlstuff.urlsplit(full_url)[2]
    relative_url = path.lstrip('/')
    relative_url = os.path.normpath(relative_url)
    # local_file_path = os.path.join(root_dir, relative_url)
    local_file_path = relative_url
    # print("Downloading %s..." % full_url)

    if cmd_exists('wget'):
        if not installer:
            download_cmd = ['wget', "-c", "--quiet", "-x", "-nH", full_url]
            # this doesn't work as there are multiple metadata files with the same name!
            # download_cmd = ['wget', "-c", "--quiet", full_url]
        else:
            download_cmd = ['wget', "-c", full_url]
    else:
        if not installer:
            download_cmd = ['curl', "--silent", "--show-error", "-o", local_file_path, "--create-dirs", full_url]
        else:
            local_file_path = os.path.basename(local_file_path)
            download_cmd = ['curl', "-o", local_file_path, full_url]

    try:
        subprocess.check_call(download_cmd)
    except subprocess.CalledProcessError as err:
        raise ReplicationError(err)
    return local_file_path


def parse_server_metadata(filename):
    '''Parses a softwareupdate server metadata file, looking for information
    of interest.
    Returns a dictionary containing title, version, and description.'''
    title = ''
    vers = ''
    try:
        md_plist = plistlib.readPlist(filename)
    except (OSError, IOError, ExpatError) as err:
        print('Error reading %s: %s' % (filename, err))
        return {}
    vers = md_plist.get('CFBundleShortVersionString', '')
    localization = md_plist.get('localization', {})
    preferred_localization = (localization.get('English') or
                              localization.get('en'))
    if preferred_localization:
        title = preferred_localization.get('title', '')

    metadata = {}
    metadata['title'] = title
    metadata['version'] = vers
    return metadata


def get_server_metadata(catalog, product_key, workdir, ignore_cache=False):
    '''Replicate ServerMetaData'''
    try:
        url = catalog['Products'][product_key]['ServerMetadataURL']
        try:
            smd_path = replicate_url(
                url, root_dir=workdir, ignore_cache=ignore_cache)
            return smd_path
        except ReplicationError as err:
            print('Could not replicate %s: %s' % (url, err))
            return None
    except KeyError:
        print('Malformed catalog.')
        return None


def parse_dist(filename):
    '''Parses a softwareupdate dist file, returning a dict of info of
    interest'''
    dist_info = {}
    try:
        dom = minidom.parse(filename)
    except ExpatError:
        print('Invalid XML in %s' % filename)
        return dist_info
    except IOError as err:
        print('Error reading %s: %s' % (filename, err))
        return dist_info

    auxinfos = dom.getElementsByTagName('auxinfo')
    if not auxinfos:
        return dist_info
    auxinfo = auxinfos[0]
    key = None
    value = None
    children = auxinfo.childNodes
    # handle the possibility that keys from auxinfo may be nested
    # within a 'dict' element
    dict_nodes = [n for n in auxinfo.childNodes
                  if n.nodeType == n.ELEMENT_NODE and
                  n.tagName == 'dict']
    if dict_nodes:
        children = dict_nodes[0].childNodes
    for node in children:
        if node.nodeType == node.ELEMENT_NODE and node.tagName == 'key':
            key = node.firstChild.wholeText
        if node.nodeType == node.ELEMENT_NODE and node.tagName == 'string':
            value = node.firstChild.wholeText
        if key and value:
            dist_info[key] = value
            key = None
            value = None
    return dist_info


def download_and_parse_sucatalog(sucatalog, workdir, ignore_cache=False):
    '''Downloads and returns a parsed softwareupdate catalog'''
    try:
        localcatalogpath = replicate_url(
            sucatalog, root_dir=workdir, ignore_cache=ignore_cache)
    except ReplicationError as err:
        print('Could not replicate %s: %s' % (sucatalog, err))
        exit(-1)
    if os.path.splitext(localcatalogpath)[1] == '.gz':
        with gzip.open(localcatalogpath) as the_file:
            content = the_file.read()
            try:
                catalog = plistlib.readPlistFromString(content)
                return catalog
            except ExpatError as err:
                print('Error reading %s: %s' % (localcatalogpath, err))
                exit(-1)
    else:
        try:
            catalog = plistlib.readPlist(localcatalogpath)
            return catalog
        except (OSError, IOError, ExpatError) as err:
            print('Error reading %s: %s' % (localcatalogpath, err))
            exit(-1)


def find_mac_os_installers(catalog):
    '''Return a list of product identifiers for what appear to be macOS
    installers'''
    mac_os_installer_products = []
    if 'Products' in catalog:
        product_keys = list(catalog['Products'].keys())
        for product_key in product_keys:
            product = catalog['Products'][product_key]
            try:
                if product['ExtendedMetaInfo'][
                        'InstallAssistantPackageIdentifiers'][
                            'OSInstall'] == 'com.apple.mpkg.OSInstall':
                    mac_os_installer_products.append(product_key)
            except KeyError:
                continue
    return mac_os_installer_products


def os_installer_product_info(catalog, workdir, ignore_cache=False):
    '''Returns a dict of info about products that look like macOS installers'''
    product_info = {}
    installer_products = find_mac_os_installers(catalog)
    for product_key in installer_products:
        product_info[product_key] = {}
        filename = get_server_metadata(catalog, product_key, workdir)
        product_info[product_key] = parse_server_metadata(filename)
        product = catalog['Products'][product_key]
        product_info[product_key]['PostDate'] = product['PostDate']
        distributions = product['Distributions']
        dist_url = distributions.get('English') or distributions.get('en')
        try:
            dist_path = replicate_url(
                dist_url, root_dir=workdir, ignore_cache=ignore_cache)
        except ReplicationError as err:
            print('Could not replicate %s: %s' % (dist_url, err))
        dist_info = parse_dist(dist_path)
        product_info[product_key]['DistributionPath'] = dist_path
        product_info[product_key].update(dist_info)

    return product_info


def replicate_product(catalog, product_id, workdir, ignore_cache=False):
    '''Downloads all the packages for a product'''
    product = catalog['Products'][product_id]
    for package in product.get('Packages', []):
        # TO-DO: Check 'Size' attribute and make sure
        # we have enough space on the target
        # filesystem before attempting to download
        if 'URL' in package:
            try:
                replicate_url(
                    package['URL'], root_dir=workdir,
                    show_progress=True, ignore_cache=ignore_cache,
                    attempt_resume=(not ignore_cache), installer=True)
            except ReplicationError as err:
                print('Could not replicate %s: %s' % (package['URL'], err))
                exit(-1)
        if 'MetadataURL' in package:
            try:
                replicate_url(package['MetadataURL'], root_dir=workdir,
                              ignore_cache=ignore_cache, installer=True)
            except ReplicationError as err:
                print('Could not replicate %s: %s' % (package['MetadataURL'], err))
                exit(-1)


def find_installer_app(mountpoint):
    '''Returns the path to the Install macOS app on the mountpoint'''
    applications_dir = os.path.join(mountpoint, 'Applications')
    for item in os.listdir(applications_dir):
        if item.endswith('.app'):
            return os.path.join(applications_dir, item)
    return None


def determine_version(version, product_info):
    if version:
        if version == 'latest':
            from distutils.version import StrictVersion
            latest_version = StrictVersion('0.0.0')
            for index, product_id in enumerate(product_info):
                d = product_info[product_id]['version']
                if d > latest_version:
                    latest_version = d

            if latest_version == StrictVersion("0.0.0"):
                print("Could not find latest version {}")
                exit(1)

            version = str(latest_version)

        for index, product_id in enumerate(product_info):
            v = product_info[product_id]['version']
            if v == version:
                return product_id

        print("Could not find version {}. Versions available are:".format(version))
        for _, pid in enumerate(product_info):
            print("- {}".format(product_info[pid]['version']))

        exit(1)

    # display a menu of choices (some seed catalogs have multiple installers)
    print('%2s %12s %10s %8s %11s  %s' % ('#', 'ProductID', 'Version',
                                          'Build', 'Post Date', 'Title'))
    for index, product_id in enumerate(product_info):
        print('%2s %12s %10s %8s %11s  %s' % (
            index + 1,
            product_id,
            product_info[product_id]['version'],
            product_info[product_id]['BUILD'],
            product_info[product_id]['PostDate'].strftime('%Y-%m-%d'),
            product_info[product_id]['title']
        ))

    answer = input(
        '\nChoose a product to download (1-%s): ' % len(product_info))
    try:
        index = int(answer) - 1
        if index < 0:
            raise ValueError
        product_id = list(product_info.keys())[index]
        return product_id
    except (ValueError, IndexError):
        pass

    print('Invalid input provided.')
    exit(0)


def main():
    '''Do the main thing here'''
    """
    if os.getuid() != 0:
        sys.exit('This command requires root (to install packages), so please '
                 'run again with sudo or as root.')
    """

    parser = argparse.ArgumentParser()
    parser.add_argument('--workdir', metavar='path_to_working_dir',
                        default='.',
                        help='Path to working directory on a volume with over '
                             '10G of available space. Defaults to current working '
                             'directory.')
    parser.add_argument('--version', metavar='version',
                        default=None,
                        help='The version to download in the format of '
                             '"$major.$minor.$patch", e.g. "10.15.4". Can '
                             'be "latest" to download the latest version.')
    parser.add_argument('--compress', action='store_true',
                        help='Output a read-only compressed disk image with '
                             'the Install macOS app at the root. This is now the '
                             'default. Use --raw to get a read-write sparse image '
                             'with the app in the Applications directory.')
    parser.add_argument('--raw', action='store_true',
                        help='Output a read-write sparse image '
                             'with the app in the Applications directory. Requires '
                             'less available disk space and is faster.')
    parser.add_argument('--ignore-cache', action='store_true',
                        help='Ignore any previously cached files.')
    parser.add_argument('--big-sur', action='store_true',
                        help='(Temporary) Hack to fetch Big Sur.')
    args = parser.parse_args()

    su_catalog_url = get_default_catalog()
    if not su_catalog_url:
        print('Could not find a default catalog url for this OS version.')
        exit(-1)

    # download sucatalog and look for products that are for macOS installers
    catalog = download_and_parse_sucatalog(
        su_catalog_url, args.workdir, ignore_cache=args.ignore_cache)

    # (Temporary) Hack to fetch Big Sur
    if args.big_sur:
        products = catalog['Products']
        # Beta 3 ID:
        product = products["001-26097"]
        workdir = "."
        ignore_cache = False
        for package in product.get('Packages', []):
            if 'URL' in package:
                try:
                    replicate_url(
                        package['URL'], root_dir=workdir,
                        show_progress=True, ignore_cache=ignore_cache,
                        attempt_resume=(not ignore_cache), installer=True, one_more_hack=True)
                except ReplicationError as err:
                    print('Could not replicate %s: %s' % (package['URL'], err))
                    exit(-1)
            if 'MetadataURL' in package:
                try:
                    replicate_url(package['MetadataURL'], root_dir=workdir,
                                  ignore_cache=ignore_cache, installer=True)
                except ReplicationError as err:
                    print('Could not replicate %s: %s' % (package['MetadataURL'], err))
                    exit(-1)
        exit(-1)

    product_info = os_installer_product_info(
        catalog, args.workdir, ignore_cache=args.ignore_cache)

    if not product_info:
        print('No macOS installer products found in the sucatalog.')
        exit(-1)

    product_id = determine_version(args.version, product_info)

    # download all the packages for the selected product
    replicate_product(
        catalog, product_id, args.workdir, ignore_cache=args.ignore_cache)


if __name__ == '__main__':
    main()
