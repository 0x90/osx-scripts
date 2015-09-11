#!/usr/bin/env bash
# greetz: jbfc.ru

sudo port install libconfig-hr readline lua jansson lua51 python34 libevent
#sudo port select gcc none

export CFLAGS="-I/usr/local/include -I/opt/local/include -I/opt/local/include/lua-5.1"
export LDFLAGS="-L/usr/local/lib -L/opt/local/lib -L/opt/local/lib/lua-5.1"

cd /tmp
git clone --recursive https://github.com/vysheng/tg.git
cd tg
#sed -i.bak 's/-Wno-deprecated //g' Makefile.in
./configure && make

echo "Installing Telegram cli to: /usr/local/tg"
sudo cp -R bin /usr/local/tg

echo "Cleanup.."
cd /tmp && rm -rf rg

echo ""
echo "Please /usr/local/tg add to PATH env."
echo ""


