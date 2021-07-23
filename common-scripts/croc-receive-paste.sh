#!/bin/sh

str="$( croc jobacsbakulawcityofsmiles87 )"

echo "$str" | xsel -i -b

xdotool key --clearmodifiers Ctrl+v


