#!/usr/bin/sh

in=/home/jonathan/Documents/notes/remove-newlines.txt
out=/home/jonathan/Documents/notes/remove-newlines-out.txt

cp $in $out

sed '/^$/d' $out > $in

rm $out