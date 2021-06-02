#!/usr/bin/bash 

notify-send "Uploading all docs to Gdrive."

/usr/bin/rclone sync --copy-links --progress --include "/Documents/**" --include "/.bash**" --include "/.texpander/**" /home/jonathan gdrive:Dell_Laptop &&

/usr/bin/rclone sync --copy-links --progress "/home/jonathan/Old-Docs/excel/shs/20-21/" "gdrive:documents/excel/shs/20-21" &&

/usr/bin/rclone sync --progress "/home/jonathan/Old-Docs/latex/20-21/" "gdrive:documents/latex/20-21" &&

/usr/bin/rclone sync --progress "/home/jonathan/Videos/" "gdrive:documents/videos" &&

#/usr/bin/rclone sync --progress "/home/jonathan/Android-Development"

notify-send "Uploaded docs to Gdrive."

# copy --update --transfers 30 --checkers 8 --contimeout 60s --timeout 300s --retries 3 --low-level-retries 10 --stats 1s
