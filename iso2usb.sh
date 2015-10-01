#!/usr/bin/env bash
# Write ISO to USB flash drive

check_euid(){
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be ran with sudo or root privileges, or this isn't going to work."
        exit 1
    fi
}

# TODO: add checking args
check_euid
diskutil unmountDisk $2
dd if=$1 of=$2 bs=1m && sync
diskutil eject $2
