DRAFTNAME=$(shell grep docName template.xml | sed -e 's/.*docName=\"//' -e 's/\">//')

all:	$(DRAFTNAME).txt $(DRAFTNAME).html

%.xml:	%.mkd transform.xsl
	pandoc $< -t docbook -s | xsltproc transform.xsl - > $@

draft.txt:	middle.xml back.xml abstract.xml template.xml
	DISPLAY= xml2rfc template.xml draft.txt

draft.html:	middle.xml back.xml abstract.xml template.xml
	DISPLAY= xml2rfc template.xml draft.html

$(DRAFTNAME).txt:	draft.txt
	ln -sf $< $(DRAFTNAME).txt

$(DRAFTNAME).html:	draft.html
	ln -sf $< $(DRAFTNAME).html

nits:   $(DRAFTNAME).txt
	idnits --year 2011 --verbose $<

clean:
	rm -f middle.xml back.xml abstract.xml

realclean: clean
	rm -f $(DRAFTNAME).txt $(DRAFTNAME).html draft.txt draft.html
