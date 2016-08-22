#!/bin/bash
# This script will turn the AirPort on and off
# until the country code is different from "SY"
#
# author: Martin Bartos (f1lth@msn.com)
# modified: Szilveszter Molnar (mail@moszi.net)

if [[ $EUID -ne 0 ]]; then
    echo " This script must be run as root" 1>&2
    exit 1
fi


cont=1


while [[ $cont -ge 1 ]]; do
    echo
    log=`system_profiler SPAirPortDataType |grep "Supported Channels:" | cut -d "," -f 12`

    if [[ $log != " 12" ]]; then
	echo $log
	echo -n " Restarting AirPort [$cont] ... "
	sudo networksetup -setairportpower en1 off
	sleep 6
	sudo networksetup -setairportpower en1 on
	sleep 2
	let "cont+=1"
	echo " DONE"
    else
	echo $log
	echo " Happy Networking "
	echo
	cont=0
    fi
done
exit 0
