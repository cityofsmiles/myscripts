#!/bin/sh

str="$( xsel -p )"

croc send --text "$str" --code jobacsbakulawcityofsmiles87

notify-send "Clipboard entry sent."
