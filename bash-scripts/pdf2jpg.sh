#!/usr/bin/sh

in="$1"
#out="$2"
out="${in%.*}"

vips copy $in[dpi=600] $out.jpeg
#echo $out.jpeg