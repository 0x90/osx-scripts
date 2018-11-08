#!/bin/bash

sudo rm -rf "/Library/Application Support/Paragon Software/"
sudo rm /Library/LaunchDaemons/com.paragon-software.installer.plist
sudo rm /Library/LaunchDaemons/com.paragon-software.ntfs.loader.plist
sudo rm /Library/LaunchDaemons/com.paragon-software.ntfsd.plist
sudo rm /Library/LaunchAgents/com.paragon-software.ntfs.notification-agent.plist
sudo rm -rf /Library/Filesystems/ufsd_NTFS.fs/
sudo rm -rf /Library/PrivilegedHelperTools/com.paragon-software.installer
sudo rm -rf /Library/Extensions/ufsd_NTFS.kext/
sudo rm -rf /Library/PreferencePanes/ParagonNTFS.prefPane

sudo rm -rf /Library/Filesystems/ufsd_ExtFS.fs
sudo rm -rf /Library/Extensions/ufsd_ExtFS.kext
sudo rm -f /Library/LaunchDaemons/com.paragon-software.extfs.loader.plist
sudo rm -f /Library/LaunchDaemons/com.paragon-software.extfsd.plist
sudo rm -f /Library/LaunchAgents/com.paragon-software.extfs.notification-agent.plist