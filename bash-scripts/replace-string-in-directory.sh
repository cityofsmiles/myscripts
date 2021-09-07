#!/bin/bash

# bash /home/jonathan/Documents/laptop/scripts/replace-string-in-directory.sh 

dir=$(pwd)

str="$1"

replace="$2"

grep -rl $str $dir | xargs sed -i "s|$str|$replace|g"