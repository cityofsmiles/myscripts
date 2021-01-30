#!/usr/bin/bash
#img=(`find /home/jonathan/Documents/wallpapers -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' | cut -d':' -f1`)
#wallpapers='/home/jonathan/Documents/wallpapers'

sleep 2m

while true
do
#   feh --bg-scale "${img[$RANDOM % ${#img[@]} ]}"
	feh --bg-scale --randomize /home/jonathan/Documents/wallpapers/* &
	sleep 10m
done
