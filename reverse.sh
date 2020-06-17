#!/bin/env bash

sudo port install cmake
# https://github.com/keystone-engine/keystone
# https://github.com/aquynh/capstone
# https://github.com/unicorn-engine/unicorn

git clone https://github.com/keystone-engine/keystone
cd keystone
mkdir build
cd build
../make-share.sh
sudo make install
