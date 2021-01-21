#!/usr/bin/sh

in="$1"
out="$2"

vips copy $in[dpi=600] $out
