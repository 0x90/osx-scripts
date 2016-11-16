#!/bin/bash
if [ $1 ]; then
  case $1 in
        -U|-u|-unload|u|U)
            sudo kextunload -b com.FTDI.driver.FTDIUSBSerialDriver;;
        -l|-L|-load|l|L)
            sudo kextload -b com.FTDI.driver.FTDIUSBSerialDriver;;
  esac
else
  echo "use keys (-unload or -load)"
fi
