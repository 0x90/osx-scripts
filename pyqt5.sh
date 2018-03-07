#!/usr/bin/env bash
# PyQt5 + sip installation
# Comptibility: OSX, Macports, Python 2/3, virtualenv/pyenv

wget http://freefr.dl.sourceforge.net/project/pyqt/sip/sip-4.19.1/sip-4.19.1.tar.gz
wget http://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.8.2/PyQt5_gpl-5.8.2.tar.gz

tar xzf sip-4.19.1.tar.gz
cd sip-4.19.1
python configure.py -d ~/.pyenv/versions/binja/lib/python2.7/site-packages/
make && make install


cd ..
tar xzf PyQt5_gpl-5.8.2.tar.gz
cd PyQt5_gpl-5.8.2
python configure.py --confirm-license -d /Users/090h/.pyenv/versions/binja/lib/python2.7/site-packages/ --qmake=/opt/local/bin/qmake --sip=/Users/090h/.pyenv/versions/binja/bin/sip --sip-incdir=../sip-4.19.1/siplib
make && make install