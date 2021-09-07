#!/usr/bin/bash

source /home/jonathan/Documents/laptop/scripts/bash-scripts/config.sh


while inotifywait -r -e modify,attrib,close_write,move,create,delete /home/jonathan/Old-Docs/latex/20-21/
do

rsync -av --delete  --rsh='ssh -p22' --exclude '.git/*' /home/jonathan/Old-Docs/latex/20-21/ $user_pine@$ip_pine:~/Documents/latex/20-21 &&


notify-send "Uploaded tex files to pinephone!"

done


