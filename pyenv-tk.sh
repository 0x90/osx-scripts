#!/bin/bash
# Install Python+Tkinter+PyQt5 inside pyenv
# Tested on: OSX Sierra + MacPorts

# Requirements
# sudo port install expat readline # py-gnureadline
# porti openssl py-openssl

# Libs
# export TCL_LIBRARY="/opt/local/lib/tcl8.6"
# export TK_LIBRARY="/opt/local/lib/tk8.6"
# $ pkg-config --libs tk
# -L/opt/local/lib -ltk8.6 -ltkstub8.6 -ltcl8.6 -ltclstub8.6

# build flags
# export CFLAGS="${CFLAGS} -O2 -I/opt/local/include"
# export CPPFLAGS="${CPPFLAGS} -O2 -I/opt/local/include"
# export CPPFLAGS="-I/opt/local/include -I/opt/local/include/openssl"
# export LDFLAGS="${LDFLAGS} -L/opt/local/lib/"

# export CFLAGS="-I/opt/local/include"
# export CPPFLAGS="-I/opt/local/include -I/opt/local/include/openssl"
# export LDFLAGS="-L/opt/local/lib"

# Python configure flags
# export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes=\"-I/opt/local/include\" --with-tcltk-libs=\"-L/opt/local/lib\""
# export PYTHON_CONFIGURE_OPTS="--enable-framework --with-tcltk-includes=\"-I/opt/local/include\" --with-tcltk-libs=\"-L/opt/local/lib\""
# export PYTHON_CONFIGURE_OPTS="--enable-ipv6 --enable-framework --enable-optimizations --with-tcltk-includes=\"-I/opt/local/include\" --with-tcltk-libs=\"-L/opt/local/lib\""
# --with-fpectl
# --with-pydebug
# --with-system-expat \
# --with-system-ffi   \
# --with-ensurepip=yes \


# export PYTHON_CONFIGURE_OPTS="--enable-loadable-sqlite-extensions --enable-shared --enable-ipv6 --enable-unicode=ucs4 --with-tcltk-includes='-I/opt/local/include' --with-tcltk-libs='-L/opt/local/lib'"
# --enable-shared \ --with-system-expat \ --with-system-ffi \ --with-ensurepip=yes \ --enable-unicode=ucs
# export PYTHON_CONFIGURE_OPTS="--enable-optimizations --enable-loadable-sqlite-extensions --with-pydebug --enable-ipv6 --enable-unicode=ucs4 --with-tcltk-includes='-I/opt/local/include' --with-tcltk-libs='-L/opt/local/lib'"

export CFLAGS="-O2 -I/opt/local/include -I/opt/local/include/readline -I/opt/local/include/openssl"
export CPPFLAGS="-O2 -I/opt/local/include -I/opt/local/include/readline -I/opt/local/include/openssl"
export LDFLAGS="-L/opt/local/lib/"
# export PYTHON_CONFIGURE_OPTS="--enable-framework --with-tcltk-includes=\"-I/opt/local/include\" --with-tcltk-libs=\"-L/opt/local/lib\""
# export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes=\"-I/opt/local/include\" --with-tcltk-libs=\"-L/opt/local/lib\""

pyenv install -vfk 2.7.14
pyenv install -vfk 3.6.4

# env PYTHON_CONFIGURE_OPTS="--enable-framework"
# pyenv install 3.6.4


export PYTHON_CONFIGURE_OPTS="--enable-shared --with-system-expat"