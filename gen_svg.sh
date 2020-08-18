#!/bin/sh

sed -e "s;%TIKZNAME%;$1;g" ./template.tex > $1.tex
xelatex $1.tex
pdf2svg $1.pdf $1.svg
