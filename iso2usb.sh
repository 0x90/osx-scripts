#!/usr/bin/env bash
# Write ISO to USB flash drive

# TODO: check euid
# TODO: add checking args
diskutil unmountDisk $2
dd if=$1 of=$2 bs=1m && sync
diskutil eject $2
