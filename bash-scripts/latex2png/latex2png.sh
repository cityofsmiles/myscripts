#!/bin/sh

text="$1"
 
echo "$text" > text.tex

pdflatex -shell-escape latex2png.tex

feh latex2png.png
