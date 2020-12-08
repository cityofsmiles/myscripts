#!/usr/bin/bash

source /home/jonathan/Documents/myscripts/bash-scripts/config.sh


while inotifywait -r -e modify,attrib,close_write,move,create,delete /home/jonathan/Old-Docs/txt/notes/
do

rsync -av --delete  --rsh='ssh -p8022' /home/jonathan/Old-Docs/txt/notes/ $user_cp@$ip_cp:/storage/4A3C-18EA/Android/data/com.termux/files/Documents/documents/txt/notes &&


notify-send "Uploaded notes!"

done
