#!/bin/env bash

#Save the list of installed ports:
port -qv installed > myports.txt
#(optional) Save the list of requested ports:
port echo requested | cut -d ' ' -f 1 > requested.txt
#Uninstall all installed ports:
sudo port -f uninstall installed
#Clean any partially-completed builds:
sudo rm -rf /opt/local/var/macports/build/*
#Download and execute the restore_ports script. (If you installed MacPorts from source and used a custom prefix, then you'll need to use the -p option when you run restore_ports.tcl; see ./restore_ports.tcl -h.)
curl -O https://svn.macports.org/repository/macports/contrib/restore_ports/restore_ports.tcl
chmod +x restore_ports.tcl
sudo ./restore_ports.tcl myports.txt
#(optional) Restore requested status: If you saved the list of requested ports, you can now restore the requested flags for your newly installed ports to their former states.
sudo port unsetrequested installed
xargs sudo port setrequested < requested.txt
