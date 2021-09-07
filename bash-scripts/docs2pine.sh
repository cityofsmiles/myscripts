#!/usr/bin/bash

source /home/jonathan/Documents/laptop/scripts/bash-scripts/config.sh

while inotifywait -r -e modify,attrib,close_write,move,create,delete /home/jonathan/Documents/
do

#rsync -av --delete --rsh='ssh -p22' --exclude 'grade8-repository/master/.git/*' --exclude 'grade8-repository/assets/Grade8Lessons/.git/*' --exclude 'grade8-repository/calendar/Grade8Lessons/.git/*' --exclude 'myscripts/python-scripts/ExamAutoChecker/.git/*' --exclude 'myscripts/python-scripts/ExamAutoCheckerAssets/ExamAutoChecker/.git/*' --exclude 'myscripts/.git/*' --exclude 'myscripts/firefox*' /home/jonathan/Documents/ $user_pine@$ip_pine:/home/jonathan/Documents/laptop &&

rsync -av --delete --rsh='ssh -p22' --exclude-from=/home/jonathan/Documents/laptop/scripts/bash-scripts/exclude-files.txt /home/jonathan/Documents/ $user_pine@$ip_pine:~/Documents/laptop &&

notify-send "Uploaded docs to pinephone!"

done
