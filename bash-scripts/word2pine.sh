#!/usr/bin/bash

source /home/jonathan/Documents/myscripts/bash-scripts/config.sh


while inotifywait -r -e modify,attrib,close_write,move,create,delete /home/jonathan/Old-Docs/word/shs/20-21/
do

rsync -av --delete  --rsh='ssh -p22' /home/jonathan/Old-Docs/word/shs/20-21/ $user_pine@$ip_pine:~/Documents/word/20-21 &&


notify-send "Uploaded docx files to pinephone!"

done
