#!/usr/bin/bash

#cd /home/jonathan/Pictures
cd /home/jonathan/Documents/laptop/ipcrf-proofs/21-22/classes

day=$( date +"%F_%H-%M-%S" )

origname="$( xsel -b -o )"

echo 'Type filename'

read filename

mv $origname $filename-$day.png && notify-send "screenshot saved"



