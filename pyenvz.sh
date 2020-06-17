#!/bin/sh

env PYTHON_CONFIGURE_OPTS="--enable-shared --with-system-expat --with-tcltk-includes=\"-I/opt/local/include\" --with-tcltk-libs=\"-L/opt/local/lib\"" pyenv install -vfk 2.7.15
env PYTHON_CONFIGURE_OPTS="--enable-shared --with-system-expat --with-tcltk-includes=\"-I/opt/local/include\" --with-tcltk-libs=\"-L/opt/local/lib\"" pyenv install -vfk 3.5.6
env PYTHON_CONFIGURE_OPTS="--enable-shared --with-system-expat --with-tcltk-includes=\"-I/opt/local/include\" --with-tcltk-libs=\"-L/opt/local/lib\"" pyenv install -vfk 3.6.8