#!/bin/bash

file="$1"

path=$(realpath "$file")

filename="$(basename $path)"

echo $filename | xclip -selection clipboard 

