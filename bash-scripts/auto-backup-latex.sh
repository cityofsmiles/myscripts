#!/bin/bash

source /home/jonathan/Documents/laptop/scripts/bash-scripts/config.sh

while inotifywait -r -e modify,attrib,close_write,move,create,delete ~/Old-Docs/latex/20-21

do
notify-send "Uploading tex files."

/usr/bin/rclone sync "/home/jonathan/Old-Docs/latex/20-21/" "nextcloud:20-21" &&

notify-send "Uploaded tex files!"

ssh -p 8022 u0_a295@$ip_cp bash /storage/emulated/0/GNURoot/home/Scripts/termux/bash-scripts/latexnextcloud2cp.sh

done
