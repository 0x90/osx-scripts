#!/bin/bash

sudo kextunload -b  org.virtualbox.kext.VBoxNetAdp
sudo kextunload -b  org.virtualbox.kext.VBoxNetFlt
sudo kextunload -b  org.virtualbox.kext.VBoxUSB
sudo kextunload -b  org.virtualbox.kext.VBoxDrv
