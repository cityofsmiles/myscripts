#!/usr/bin/bash

str="$1"

lower=$(echo "$str" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
echo $lower
echo $lower | xclip -sel clip

