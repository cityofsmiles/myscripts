#!/usr/bin/bash

filename='/home/jonathan/Downloads/autotext-backup.txt'

numlines=$( wc -l $filename | awk '{ print $1 }' )

entries_dir='/home/jonathan/autotext'

mkdir -p $entries_dir

cd $entries_dir

n=1
while read line; 
do

if [[ $n -gt 1 && $n -lt $numlines ]]; then
    abbr=${line%%:*} 
    long_text="${line##*:}"
    echo "Creating $abbr"
    touch $abbr
    echo "$long_text" > "$abbr"
fi

n=$((n+1))

done < $filename

