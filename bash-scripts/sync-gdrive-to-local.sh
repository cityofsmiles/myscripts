#!/bin/bash


while inotifywait -r -e modify,attrib,close_write,move,create,delete ~/googledrive/Dell_Laptop/Documents

do
rclone sync /home/jonathan/googledrive/Dell_Laptop/Documents/ /home/jonathan/Documents --verbose
notify-send "Done syncing to local!"
done