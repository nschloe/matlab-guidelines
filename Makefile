# ./Makefile

# ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

LATEX:=lualatex
BIBTEX:=biber
GHOSTSCRIPT:=gs

# ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

TARGET:=main

# ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 

default: main

main:
	@$(LATEX) $(TARGET)
	@$(GHOSTSCRIPT) -q -dBATCH -dNOPAUSE -dSAFER -dFastWebView -sDEVICE=pdfwrite \
	 -dPDFSETTINGS=/default -sOutputFile=out.pdf $(TARGET).pdf

bib:
	@$(BIBTEX) $(TARGET)

.PHONY: clean

clean:
	@rm -f $(TARGET)-blx.bib \
         $(TARGET).aux \
         $(TARGET).bcf \
         $(TARGET).blg \
         $(TARGET).log \
         $(TARGET).out \
         $(TARGET).pdf \
         $(TARGET).toc \
         $(TARGET).nav \
         $(TARGET).bbl \
         $(TARGET).thm \
         $(TARGET).run.xml \
         $(TARGET).pyg \
         $(TARGET).out.pyg \
         missfont.log \
         *~
