#!/usr/bin/bash

notify-send "Downloading files from NextCloud"

/usr/bin/rclone sync nextcloud:Document /home/jonathan/Documents &&

/usr/bin/rclone sync "nextcloud:shs/20-21/" "/home/jonathan/Old-Docs/excel/shs/20-21" &&

/usr/bin/rclone sync "nextcloud:20-21/" "/home/jonathan/Old-Docs/latex/20-21" &&

notify-send "Downloaded files!"
