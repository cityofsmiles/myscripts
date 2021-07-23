#!/usr/bin/sh

notify-send "Receiving file."

dir=/home/alarm/Downloads/croc

mkdir $dir

cd $dir

croc --yes --overwrite jobacsbakulawcityofsmiles87 

xfce4-terminal --zoom=1.5 --command="ranger $dir"


