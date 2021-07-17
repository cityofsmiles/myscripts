#!/bin/bash

file="$1"

path=$(realpath "$file")

dir="$(dirname $path)"

echo $dir | xclip -selection clipboard 

