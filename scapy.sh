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
port install libdnet py27-libdnet py-readline py-gnuplot py-crypto py-pyx swig gnuplot graphviz

echo "Installed patched version of pylibpcap"
pip install -e "git+https://github.com/0x90/pylibpcap-osx#egg=pylibpcap-osx"

echo "Installed patched version of scapy"
pip install -e "git+https://github.com/0x90/scapy-osx#egg=scapy"
