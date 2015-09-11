#!/bin/bash
#
# Install scapy+pylibpcap+rfmon patch in Mac OS X
#


# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!" 1>&2
   exit 1
fi

# Check for MacPorts installed
if [ ! -f /opt/local/bin/port ]; then
    echo "Please install Xcode and MacPorts first!"
    exit 1
fi

echo "Installing dependencies.."
port selfupdate
port install libdnet py27-libdnet py-readline py-gnuplot py-crypto py-pyx swig

echo "Installed patched version of pylibpcap"
cd /tmp
wget http://downloads.sourceforge.net/project/pylibpcap/pylibpcap/0.6.4/pylibpcap-0.6.4.tar.gz
wget https://raw.githubusercontent.com/0x90/iSniff/master/patches/pylibpcap-0.6.4-rfmon-mac.patch
tar xzvf pylibpcap-0.6.4.tar.gz
patch -p0 < pylibpcap-0.6.4-rfmon-mac.patch
cd pylibpcap-0.6.4
python setup.py install

echo "Installed patched version of scapy"
cd /tmp
wget http://www.secdev.org/projects/scapy/files/scapy-2.2.0.tar.gz
wget https://raw.githubusercontent.com/0x90/iSniff/master/patches/scapy-2.2.0-rfmon-mac.patch
tar xzvf scapy-2.2.0.tar.gz
patch -p0 < scapy-2.2.0-rfmon-mac.patch
cd scapy-2.2.0
python setup.py install

echo "Cleaning /tmp"
cd /tmp
rm -f *rfmon-mac.patch
rm -f pylibpcap-0.6.4.tar.gz scapy-2.2.0.tar.gz
rm -rf pylibpcap-0.6.4 scapy-2.2.0