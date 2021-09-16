#!/bin/sh

names="$( xsel -p )"

filein=/home/jonathan/Documents/laptop/scripts/python-scripts/student-names.txt
fileout=/home/jonathan/Documents/laptop/scripts/python-scripts/student-names-out.txt

echo "$names" > $filein

cp $filein $fileout

sed '/^$/d' $fileout > $filein

rm $fileout
