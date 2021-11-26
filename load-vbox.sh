#!/bin/sh
# https://kastelo.net/blog/2017-05/coexisting-virtualbox-vmware-fusion-macos/

for id in VBoxDrv VBoxUSB VBoxNetFlt VBoxNetAdp; do
    kextload -r "/Library/Application Support/VirtualBox" \
     "/Library/Application Support/VirtualBox/$id.kext"
done