#!/bin/sh

#cuts video 

from="$1"
to="$2"
input="$3"
output="$4"

secondsfrom=$(echo $from | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')

secondsto=$(echo $to | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')

count=`expr $secondsto - $secondsfrom`

time=$(printf '%02d:%02d:%02d' $((count/3600)) $((count%3600/60)) $((count%60)))

ffmpeg -ss $from -i $input -to $time -c copy $output
