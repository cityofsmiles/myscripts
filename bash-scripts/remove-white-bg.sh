#!/usr/bin/sh

input="$1"
output="$1.png"

convert $input -transparent white $output

#rm $input

#mv $output $input