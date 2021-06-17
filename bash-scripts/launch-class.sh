#!/usr/bin/sh
xfce4-terminal --zoom=3 --command='ranger /home/jonathan/Old-Docs/latex/20-21/flashcards /home/jonathan/Old-Docs/latex/20-21/beamer-presentations/lessons/4th-grading' &
google-chrome-stable https://meet.google.com/rfs-egcq-ogw &
gromit-mpx &
brave https://github.com/cityofsmiles/Grade8Lessons https://github.com/cityofsmiles/Grade8Lessons/tree/calendar https://raw.githubusercontent.com/cityofsmiles/Grade8Lessons/assets/calendar/jun-2021-0.jpeg & 
simplescreenrecorder &

records="/home/jonathan/Old-Docs/excel/shs/20-21/Class-Records"
DOW=$(date +"%a")

case "$DOW" in 
  Mon) libreoffice $records/8-Euclid/attendance-8-Euclid.ods & ;;
  Tue) libreoffice $records/8-Fischer/attendance-8-Fischer.ods & ;;
  Thu) libreoffice $records/8-Hubble/attendance-8-Hubble.ods & ;;
  Fri) libreoffice $records/8-Kepler/attendance-8-Kepler.ods & ;;
  *) notify-send "No attendance to open.";;
esac