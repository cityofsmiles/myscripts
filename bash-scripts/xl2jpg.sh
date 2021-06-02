#!/usr/bin/bash

in="$1"

out="${in%.*}"

soffice --headless --convert-to pdf --outdir "converted" $in

cd ./converted

vips copy $out.pdf[dpi=600,page=0,n=-1] $out.jpeg

rm $out.pdf

echo "Done!"