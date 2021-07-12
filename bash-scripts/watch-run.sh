#!/usr/bin/bash

file="$1"

while inotifywait -e modify,attrib,close_write,move,create,delete $file
do

pdflatex $file &&
notify-send "Pdf created"

done
