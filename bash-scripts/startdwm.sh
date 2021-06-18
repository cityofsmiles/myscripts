#!/usr/bin/sh

while true; do

xsetroot -name "` date +"%R"`"

done &

BATT=$( acpi -b | sed 's/.*[charging|unknown], \([0-9]*\)%.*/\1/gi' )

STATUS=$( acpi -b | sed 's/.*: \([a-zA-Z]*\),.*/\1/gi' )

while true; do

xsetroot -name "`echo $BATT $STATUS`"
done &

exec dwm
