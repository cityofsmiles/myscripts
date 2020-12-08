#!/bin/bash


while inotifywait -e modify,attrib,close_write,move,create,delete /home/jonathan/.tmp

do
xclip -selection clipboard -i /home/jonathan/.tmp &&
notify-send "Text copied!"
done
