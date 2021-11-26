#!/bin/bash
#

brew tap twam/openfpga
#Install yosys using
brew install yosys
# Install icestorm using
brew install icestorm
# Install nextpnr using
brew install nextpnr --without-gui --without-arch-ecp5

# Litex
brew install json-c verilator libevent
brew cask install tuntap
lxsim --cpu-type=vexriscv


brew install json-c verilator libevent
$ brew cask install tuntap
$ lxsim --cpu-type=vexriscv