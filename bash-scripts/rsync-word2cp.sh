#!/usr/bin/bash

source /home/jonathan/Documents/myscripts/bash-scripts/config.sh


while inotifywait -r -e modify,attrib,close_write,move,create,delete /home/jonathan/Old-Docs/word/shs/20-21/
do

rsync -av --delete  --rsh='ssh -p8022' /home/jonathan/Old-Docs/word/shs/20-21/ $user_cp@$ip_cp:/storage/4A3C-18EA/Android/data/com.termux/files/Documents/documents/word/shs/20-21 &&


notify-send "Uploaded doc files!"

done
