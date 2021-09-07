#!/usr/bin/bash

source /home/jonathan/Documents/laptop/scripts/bash-scripts/config.sh


while inotifywait -r -e modify,attrib,close_write,move,create,delete /home/jonathan/Old-Docs/txt/notes/
do

rsync -av --delete  --rsh='ssh -p22' /home/jonathan/Old-Docs/txt/notes/ $user_pine@$ip_pine:~/Documents/notes &&


notify-send "Uploaded notes to pinephone!"

done
