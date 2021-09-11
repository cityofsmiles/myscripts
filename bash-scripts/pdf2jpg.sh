#!/usr/bin/sh


in="$( ls *.pdf )"
#out="$2"
out="${in%.*}"

#vips copy $in[dpi=600] $out.jpeg
#echo $out.jpeg

vips copy "$out".pdf[dpi=400,page=0,n=-1] "$out".jpeg
