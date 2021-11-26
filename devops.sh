#!/bin/bash


# TODO: zsh, etc
brew install romkatv/powerlevel10k/powerlevel10k
echo 'source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

#  brew install pipes-sh
brew install yudai/gotty/gotty


# EternalTerminal
brew install MisterTea/et/et


brew install mas
brew cask install sourcetree


$ brew tap dennisdegreef/pipethis
$ brew install pipethis

# adoptopenjdk/openjdk
#aquasecurity/trivy
#brewsci/science
#cartr/qt4
#homebrew/cask
#homebrew/cask-drivers
#homebrew/cask-fonts
#homebrew/cask-versions
#homebrew/core
#3homebrew/services
#johanhaleby/kubetail
#koekeishiya/formulae
# miderwong/flutter
# pothosware/pothos
# ruchirchawdhry/casks

# Docker
brew tap skanehira/docui
brew install docui
brew install dive

#TUI
# mc
# https://www.slant.co/options/29967/~nnn-review
# https://github.com/jarun/nnn/tree/master/plugins#installing-plugins
# https://www.slant.co/options/7576/~ranger-review
# https://www.slant.co/options/7583/~vifm-review
#
#
# https://github.com/herrbischoff/awesome-macos-command-line
# https://github.com/jaywcjlove/awesome-mac
# https://github.com/iCHAIT/awesome-macOS

# PHP
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew unlink php56
brew install php70
brew install phpbrew


brew cask install webstorm


# Python
brew install readline xz 
brew install pyenv pyenv-virtualenv pyenv-virtualenvwrapper

# https://github.com/pyenv/pyenv/issues/1066
# echo "export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk" >> ~/.zshrc

SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk MACOSX_DEPOLOYMENT_TARGET=10.14 pyenv install 2.7.18
SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk MACOSX_DEPOLOYMENT_TARGET=10.14 pyenv install 3.8.2


brew update
brew install ansible
brew link ansible


ansible-galaxy install hnakamur.homebrew-packages
ansible-galaxy install hnakamur.homebrew-cask-packages





#
# https://github.com/hukl/hostmux
brew install hukl/tap/hostmux

# https://github.com/dustinblackman/tcon

#k8s IDE
brew cask install lens