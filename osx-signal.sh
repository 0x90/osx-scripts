#!/bin/sh

# http://eliasoenal.com/2014/11/04/sigrok-for-os-x/


# http://sigrok.org/wiki/Mac_OS_X#Building_manually
# http://sigrok.org/wiki/Mac_OS_X/Dylib

# Dependencies
sudo port install git boost libusb libzip libftdi0 autoconf automake cmake glib2 python33 libtool pkgconfig

export PKG_CONFIG_PATH=/opt/local/Library/Frameworks/Python.framework/Versions/3.4/lib/pkgconfig/:/opt/local/lib/pkgconfig/

#
cd /tmp
git clone git://sigrok.org/libserialport
cd libserialport
./autogen.sh
./configure
make
sudo make install

#
cd /tmp
git clone git://sigrok.org/libsigrok
cd libsigrok
./autogen.sh
./configure
make
sudo make install

#
cd /tmp
git clone git://sigrok.org/libsigrokdecode
cd libsigrokdecode
./autogen.sh
./configure
make
sudo make install

#
cd /tmp
git clone git://sigrok.org/sigrok-cli
cd sigrok-cli
./autogen.sh
./configure
make
sudo make install

#
cd /tmp
git clone git://sigrok.org/pulseview
cd pulseview
cmake .
make
sudo make install

