#!/usr/bin/env bash
# PyQt5 + sip installation
# Comptibility: OSX, Macports, Python 2/3, virtualenv/pyenv


export CFLAGS="-O2 -I/opt/local/include -I/opt/local/include/readline -I/opt/local/include/openssl"
export CPPFLAGS="-O2 -I/opt/local/include -I/opt/local/include/readline -I/opt/local/include/openssl"
export LDFLAGS="-L/opt/local/lib/"
# export PYTHON_CONFIGURE_OPTS="--enable-framework --with-tcltk-includes=\"-I/opt/local/include\" --with-tcltk-libs=\"-L/opt/local/lib\""
# export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes=\"-I/opt/local/include\" --with-tcltk-libs=\"-L/opt/local/lib\""

pyenv install -vfk 2.7.14
pyenv install -vfk 3.6.4

# env PYTHON_CONFIGURE_OPTS="--enable-framework"

wget http://freefr.dl.sourceforge.net/project/pyqt/sip/sip-4.19.1/sip-4.19.1.tar.gz
wget http://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.8.2/PyQt5_gpl-5.8.2.tar.gz

tar xzf sip-4.19.1.tar.gz
cd sip-4.19.1
python configure.py -d ~/.pyenv/versions/binja2/lib/python2.7/site-packages/
make && make install


cd ..
tar xzf PyQt5_gpl-5.8.2.tar.gz
cd PyQt5_gpl-5.8.2
python configure.py --confirm-license -d ${HOME}/.pyenv/versions/binja2/lib/python2.7/site-packages/ --qmake=/opt/local/bin/qmake --sip=${HOME}/.pyenv/versions/binja2/bin/sip --sip-incdir=../sip-4.19.1/siplib
make && make install
