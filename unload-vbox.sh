#!/bin/sh
# https://kastelo.net/blog/2017-05/coexisting-virtualbox-vmware-fusion-macos/

for id in VBoxNetAdp VBoxNetFlt VBoxUSB VBoxDrv; do
    kextunload -b "org.virtualbox.kext.$id"
done