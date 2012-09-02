
# This makefile requires GNU make.
# What: A makefile macro function to 
# target1 target2 target3 : prerequisite1 prerequisite2  prerequisite3
#         command 1
#         command 2
# $< : The filename of the first prerequisite.
# $@ : The filename representing the target
# $< : The filename of the first prerequsite.
# $? : The names of all prequisites that are newer than the target, separated by spaces.
# $^ : The filnames of all the prerequisites,separted by spaces.
# $+ : Similar to $^, this i sthe names of all the prerequisites separated by spaces.
# $* : The stem of the target filname. A stem is typically a filname without its suffix.

BOOKNAME := cpam
BOOKPATH := /pub/programming/googlecode/cpam/doc/cpambook
OUTDIR   := output
XELATEX  := /usr/bin/xelatex
MAKEINDEX:= /usr/bin/makeindex
BIBTEX   := /usr/bin/bibtex
ASPELL   := /usr/bin/aspell
XELATEX_FLAGS :=-output-directory=$(OUTDIR)
TeX_SRC := *.tex ex-*/*.tex src/*.go tab/*.tex fig/*.tex about-*.tex blocksbook.cls go.bib .fig .tab .diagram

.PHONY: once spell compilecheck fmtcheck

all:	$(OUTDIR)/$(BOOKNAME).pdf

$(OUTDIR)/$(BOOKNAME).pdf: $(TeX_SRC) 
	rm -f $(BOOKNAME).tex && ln -s $(BOOKNAME)_a4.tex $(BOOKNAME).tex
	$(XELATEX)   $(XELATEX_FLAGS) $(BOOKNAME).tex && \
        $(BIBTEX)    $(OUTDIR)/$(BOOKNAME) && \
        $(MAKEINDEX) $(OUTDIR)/$(BOOKNAME) && \
        $(XELATEX)   $(XELATEX_FLAGS) $(BOOKNAME).tex && \
        $(XELATEX)   $(XELATEX_FLAGS) $(BOOKNAME).tex

.diagram: diagram/*.dia
	(cd diagram; make all )
	touch .diagram


.fig:	fig/*.svg
	(cd fig; make all )
	touch .fig

.tab:	
	(cd tab; make all )
	touch .tab

cleanall: clean clean_pictures

clean_pictures:
	rm -f .fig .diagram .tab
	(cd fig;make clean)

clean:
	rm -f $(OUTDIR)/* *~

distclean: clean
	( cd fig; make clean )
	( cd tab; make clean )
	( cd src; make clean )

spell:
	for i in *.tex ex-*/*.tex; do $(ASPELL) check $$i; done
once:	
	$(XELATEX) $(XELATEX_FLAGS) $(BOOKNAME).tex

compilecheck:
	@bin/go-lstinputlisting.pl $(BOOKPATH)   *.tex
	@bin/go-lstinputlisting.pl $(BOOKPATH)   ex-*/*.tex
	@bin/go-lstinputlisting.pl $(BOOKPATH)   fig/*.tex
	@rm -f *.6 *.8 

fmtcheck:
	@bin/go-lstlisting.pl *.tex
	@bin/go-lstlisting.pl ex-*/*.tex
	@bin/go-lstlisting.pl fig/*.tex
