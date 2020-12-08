#!/bin/bash


rclone copy --include "/Documents/**" --include "/.bash**" /home/jonathan gdrive:Dell_Laptop --verbose

notify-send "Done syncing!"