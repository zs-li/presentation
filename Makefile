PNGS    := $(wildcard *.png)
PNGMETAS:= $(patsubst %.png,%.meta,$(PNGS))

GIFS    := $(wildcard *.gif)
GIFMETAS:= $(patsubst %.gif,%.meta,$(GIFS))

JPGS    := $(wildcard *.jpg)
JPGMETAS:= $(patsubst %.jpg,%.meta,$(JPGS))

TIKZS     := $(wildcard *.tikz)
TIKZTEXS  := $(patsubst %.tikz,%.tex,$(TIKZS))
TIKZPDFS  := $(patsubst %.tikz,%.pdf,$(TIKZS))
TIKZSVGS  := $(patsubst %.tikz,%.svg,$(TIKZS))
TIKZPNGS  := $(patsubst %.tikz,%.png,$(TIKZS))
TIKZMETAS := $(patsubst %.tikz,%.meta,$(TIKZS))

.PHONY: all clean pics

all: pics

pics: $(PNGMETAS) $(GIFMETAS) $(JPGMETAS) $(TIKZMETAS) $(TIKZPNGS) $(TIKZSVGS)

%.tex: %.tikz
	sed -e "s;%TIKZNAME%;$(basename $^);g" ./template.tex > $@

%.pdf: %.tex
	xelatex $^
	rm $(basename $^).log $(basename $^).aux

%.svg: %.pdf
	pdf2svg $^ $@

%.png: %.pdf
	pdftoppm -r 300 -png $^ tmp
	mv tmp-1.png $@

%.meta: %.png
	./gen_meta.sh $^ > $@

%.meta: %.gif
	./gen_meta.sh $^ > $@

%.meta: %.jpg
	./gen_meta.sh $^ > $@

clean:
	rm $(PNGMETAS) $(GIFMETAS) $(JPGMETAS) $(TIKZTEXS) $(TIKZPDFS) $(TIKZSVGS) $(TIKZPNGS) $(TIKZMETAS) *.aux *.log
