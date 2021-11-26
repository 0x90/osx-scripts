#!/bin/bash

#For compilers to find readline you may need to set:
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"

#For pkg-config to find readline you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"


export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
export PATH="/usr/local/opt/openssl@1.1/bin:PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=(brew --prefix openssl@1.1)"


export PKG_CONFIG_PATH="$(brew --prefix openssl)/lib/pkgconfig"
export CPPFLAGS="-I$(brew --prefix readline)/include"
export LDFLAGS="-L$(brew --prefix readline)/lib"


brew install zlib
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
pyenv install 3.7.2


# XCccccode


CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install 3.6.5


# ~/.env-exporter
# about zlib
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
# about readline
export CFLAGS="-I$(brew --prefix readline)/include $CFLAGS"
export LDFLAGS="-L$(brew --prefix readline)/lib $LDFLAGS"
# about openssl
export CFLAGS="-I$(brew --prefix openssl)/include $CFLAGS"
export LDFLAGS="-L$(brew --prefix openssl)/lib $LDFLAGS"
# about SQLite (maybe not necessary)
export CFLAGS="-I$(brew --prefix sqlite)/include $CFLAGS"
export LDFLAGS="-L$(brew --prefix sqlite)/lib $LDFLAGS"

