#!/usr/bin/sh

in=remove-newlines.txt
out=remove-newlines-out.txt

xsel -ob > $in

cp $in $out

sed '/^$/d' $out > $in

rm $out

cat $in | xsel -ib

rm $in