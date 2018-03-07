#!/bin/bash
# Install python with Tk inside pyenv

# Requirements
# sudo port install expat readline # py-gnureadline

# Libs
# export TCL_LIBRARY="/opt/local/lib/tcl8.6"
# export TK_LIBRARY="/opt/local/lib/tk8.6"

# Flags
# export CFLAGS="-O2 -I/opt/local/include"
# export CPPFLAGS="-O2 -I/opt/local/include"
# export LDFLAGS="-L/opt/local/lib/" # -Wl,-rpath=/opt/local/lib,--no-as-needed"

# $ pkg-config --libs tk
# -L/opt/local/lib -ltk8.6 -ltkstub8.6 -ltcl8.6 -ltclstub8.6

# Python configure flags
# export PYTHON_CONFIGURE_OPTS="--enable-loadable-sqlite-extensions --enable-shared --enable-ipv6 --enable-unicode=ucs4 --with-tcltk-includes='-I/opt/local/include' --with-tcltk-libs='-L/opt/local/lib'"

# --enable-shared \ --with-system-expat \ --with-system-ffi \ --with-ensurepip=yes \ --enable-unicode=ucs
# export PYTHON_CONFIGURE_OPTS="--enable-optimizations --enable-loadable-sqlite-extensions --with-pydebug --enable-ipv6 --enable-unicode=ucs4 --with-tcltk-includes='-I/opt/local/include' --with-tcltk-libs='-L/opt/local/lib'"
export PYTHON_CONFIGURE_OPTS="--enable-ipv6 --enable-unicode=ucs4 --with-tcltk-includes=\"-I/opt/local/include\" --with-tcltk-libs=\"-L/opt/local/lib\""
# --with-fpectl
# --with-pydebug 
# --with-system-expat \
# --with-system-ffi   \
# --with-ensurepip=yes \

pyenv install -vfk 2.7.14
