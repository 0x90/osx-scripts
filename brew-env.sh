#!/bin/bash

#For compilers to find readline you may need to set:
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"

#For pkg-config to find readline you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
