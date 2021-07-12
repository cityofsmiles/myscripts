#!/usr/bin/sh

in=remove-newlines.txt
out=remove-newlines-out.txt

cp $in $out

sed '/^$/d' $out > $in

rm $out
