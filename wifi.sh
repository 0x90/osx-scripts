#!/bin/bash

brew install pkg-tool libmicrohttpd python3 libpcap protobuf protobuf-c pcre librtlsdr libbtbb ubertooth
git clone https://www.kismetwireless.net/git/kismet.git
./configure && make -j 4
sudo make suidinstall



brew tap pothosware/homebrew-pothos
brew update
brew install limesuite

