#!/usr/bin/bash 

notify-send "Uploading all docs to Gdrive."

#/usr/bin/rclone sync --copy-links --progress --include "/Documents/**" --include "/.bash**" --include "/.texpander/**" /home/jonathan depedgdrive:Dell_Laptop &&

/usr/bin/rclone sync --copy-links --progress "/home/jonathan/Old-Docs/excel/shs/20-21/" "depedgdrive:documents/excel/shs/20-21" &&

/usr/bin/rclone sync --progress "/home/jonathan/Old-Docs/latex/20-21/" "depedgdrive:documents/latex/20-21" &&

/usr/bin/rclone sync --copy-links --progress "/home/jonathan/Old-Docs/excel/shs/21-22/" "depedgdrive:documents/excel/shs/21-22" &&

/usr/bin/rclone sync --progress "/home/jonathan/Old-Docs/latex/21-22/" "depedgdrive:documents/latex/21-22" &&
#/usr/bin/rclone sync --progress "/home/jonathan/Videos/" "depedgdrive:documents/videos" &&

#/usr/bin/rclone sync --progress "/home/jonathan/Android-Development"

notify-send "Uploaded docs to Gdrive."

# copy --update --transfers 30 --checkers 8 --contimeout 60s --timeout 300s --retries 3 --low-level-retries 10 --stats 1s
