DRAFTNAME=$(shell grep docName template.xml | sed -e 's/.*docName=\"//' -e 's/\">//')

all:	$(DRAFTNAME).txt $(DRAFTNAME).html

abstract.xml: abstract.mkd
	pandoc abstract.mkd -t docbook -s | xsltproc transform.xsl - > abstract.xml

middle.xml: middle.mkd transform.xsl
	pandoc middle.mkd -t docbook -s | xsltproc transform.xsl - > middle.xml

back.xml:  back.mkd transform.xsl
	pandoc back.mkd -t docbook -s | xsltproc transform.xsl - > back.xml

draft.txt:	middle.xml back.xml abstract.xml template.xml
	DISPLAY= xml2rfc template.xml draft.txt

draft.html:	middle.xml back.xml abstract.xml template.xml
	DISPLAY= xml2rfc template.xml draft.html

$(DRAFTNAME).txt:	draft.txt
	mv $< $(DRAFTNAME).txt

#draft-nsec4-00.txt:	draft.txt
#	cp $< $(DRAFTNAME).txt

$(DRAFTNAME).html:	draft.html
	mv $< $(DRAFTNAME).html

nits:   $(DRAFTNAME).txt
	idnits --year 2011 --verbose $<

clean:
	rm -f middle.xml back.xml abstract.xml

realclean: clean
	rm -f $(DRAFTNAME).txt $(DRAFTNAME).html draft.txt draft.html
