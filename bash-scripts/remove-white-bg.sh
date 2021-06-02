#!/usr/bin/sh

input="$1"
output="$input-out"

convert $input -transparent white $output

rm $input

mv $output $input