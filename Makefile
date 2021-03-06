DOC=Ed_Griebel_CV

all: $(DOC).pdf images

%.pdf: %.tex
	latexmk -xelatex $?

images: $(DOC).pdf
ifneq (, $(shell hash gs 2>&1 > /dev/null && echo FOUND))
	gs -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pngmonod -r200 -sOutputFile=Miscellaneous/$(DOC)-%1d.png $?
# Old ver using ImageMagick, ghostscript works and is smaller install
## convert -density 150 -quality 90 -background white -alpha remove -alpha off $? Miscellaneous/$(DOC).png
else
	echo "'gs' command not found, is GhostScript installed?"
endif

clean:
	rm -f *.aux *.fdb_latexmk *.log *.out *.xdv xelatex*fls

cleanall: clean
	rm $(DOC).pdf
