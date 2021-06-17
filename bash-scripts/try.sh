#!/usr/bin/bash

records="/home/jonathan/Old-Docs/excel/shs/20-21/Class-Records"
DOW=$(date +"%a")

case "$DOW" in 
  Mon) libreoffice $records/8-Euclid/attendance-8-Euclid.ods & ;;
  Tue) libreoffice $records/8-Fischer/attendance-8-Fischer.ods & ;;
  Thu) libreoffice $records/8-Hubble/attendance-8-Hubble.ods & ;;
  Fri) libreoffice $records/8-Kepler/attendance-8-Kepler.ods & ;;
  *) notify-send "No attendance to open.";;
esac