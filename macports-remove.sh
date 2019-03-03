#!/bin/bash
#
# https://stackoverflow.com/questions/22305955/uninstall-macports
# https://guide.macports.org/chunked/installing.macports.uninstalling.html
#

sudo port -fp uninstall --follow-dependents installed

sudo rm -rf /opt/local 
sudo rm -rf /Applications/DarwinPorts 
sudo rm -rf /Applications/MacPorts 
sudo rm -rf /Library/LaunchDaemons/org.macports.* 
sudo rm -rf /Library/Receipts/DarwinPorts*.pkg 
sudo rm -rf /Library/Receipts/MacPorts*.pkg 
sudo rm -rf /Library/StartupItems/DarwinPortsStartup 
sudo rm -rf /Library/Tcl/darwinports1.0 
sudo rm -rf /Library/Tcl/macports1.0 
sudo rm -rf ~/.macports