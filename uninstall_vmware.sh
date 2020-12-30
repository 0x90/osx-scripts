#!/usr/bin/env bash
# Usage: bash uninstall_vmware.bash
# https://gist.github.com/pwnsdx/8bf29a7e87a78addc3a3db5f08c197f8
# https://github.com/chris1111/VMware-Fusion-Uninstaller
#

/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user


remove() {
  entry="$1"

  echo -ne "Removing $entry ["
  sudo rm -rf "$entry"

  if [[ ! -e "$entry" ]]; then
    echo -ne "OK"
  else
    echo -ne "FAILED"
  fi
  echo -ne "]"
}

remove "/Applications/VMware Fusion.app"
remove "/Library/Application Support/VMware"
remove "/Library/Application Support/VMware Fusion"
remove "/Library/Preferences/VMware Fusion"
remove "/private/var/root/Library/Logs/VMware"
remove "/private/var/db/vmware"
remove "/Library/Logs/VMware/"
remove "/Library/Logs/VMware Fusion Services.log"
remove "/Library/Logs/DiagnosticReports/vmware*"
remove "/private/var/run/vmware"
remove "/private/var/run/VMware Fusion Services.lock"
remove "/private/var/run/VMware Fusion Services.sock"
remove "/private/var/root/Library/Preferences/VMware Fusion"
remove "/var/db/BootCaches/*/app.com.vmware.fusion.playlist"
remove "$HOME/Library/Application Support/VMware Fusion"
remove "$HOME/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.vmware.fusion.sfl"
remove "$HOME/Library/Caches/com.vmware.fusion"
remove "$HOME/Library/Preferences/VMware Fusion"
remove "$HOME/Library/Logs/VMware"
remove "$HOME/Library/Logs/VMware Fusion"
remove "$HOME/Library/Preferences/VMware Fusion"
remove "$HOME/Library/Preferences/com.vmware.fusion.LSSharedFileList.plist"
remove "$HOME/Library/Preferences/com.vmware.fusion.plist"
remove "$HOME/Library/Preferences/com.vmware.fusionStartMenu.plist"
remove "$HOME/Library/Preferences/com.vmware.fusion.LSSharedFileList.plist"
remove "$HOME/Library/Preferences/com.vmware.fusion.LSSharedFileList.plist.lockfile"
remove "$HOME/Library/Preferences/com.vmware.fusion.plist"
remove "$HOME/Library/Preferences/com.vmware.fusion.plist.lockfile"
remove "$HOME/Library/Preferences/com.vmware.fusionDaemon.plist"
remove "$HOME/Library/Preferences/com.vmware.fusionDaemon.plist.lockfile"
remove "$HOME/Library/Preferences/com.vmware.fusionStartMenu.plist"
remove "$HOME/Library/Preferences/com.vmware.fusionStartMenu.plist.lockfile"