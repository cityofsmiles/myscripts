#!/bin/bash

source /home/jonathan/Documents/myscripts/bash-scripts/config.sh

while inotifywait -r -e modify,attrib,close_write,move,create,delete ~/Old-Docs/excel/shs/20-21/

do
notify-send "Uploading xlsx files."

/usr/bin/rclone sync "/home/jonathan/Old-Docs/excel/shs/20-21/" "nextcloud:shs/20-21" &&

notify-send "Uploaded xlsx files!"

ssh -p 8022 u0_a295@$ip_cp bash /storage/emulated/0/GNURoot/home/Scripts/termux/bash-scripts/excelnextcloud2cp.sh

done
