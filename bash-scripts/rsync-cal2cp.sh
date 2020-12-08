#!/usr/bin/bash

source /home/jonathan/Documents/myscripts/bash-scripts/config.sh

while inotifywait -e modify,attrib,close_write,move,create,delete /home/jonathan/calcurse.ical
do

cat /home/jonathan/calcurse.ical | ssh -p $port_cp $user_cp@$ip_cp "cat > /storage/4A3C-18EA/Android/data/com.termux/files/Calendar/calcurse.ical" &&

notify-send "Uploaded calendar!"

done
