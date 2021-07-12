#!/usr/bin/sh


in="$( ls *.pdf )"
#out="$2"
out="${in%.*}"

vips copy $in[dpi=600] $out.jpeg
#echo $out.jpeg
