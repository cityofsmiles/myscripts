#!/bin/bash

file="$1"

path=$(realpath "$file")

filename="$(basename $path)"

name=$(echo "$filename" | cut -f 1 -d '.')

echo $name | xclip -selection clipboard 

