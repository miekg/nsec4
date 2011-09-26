DRAFTNAME=$(shell grep docName template.xml | sed -e 's/.*docName=\"//' -e 's/\">//')

all:	$(DRAFTNAME).txt $(DRAFTNAME).html

abstract.xml: abstract.mkd
	pandoc abstract.mkd -t docbook -s | xsltproc transform.xsl - > abstract.xml

introduction.xml: introduction.mkd transform.xsl
	pandoc introduction.mkd -t docbook -s | xsltproc transform.xsl - > introduction.xml

middle.xml: middle.mkd transform.xsl
	pandoc middle.mkd -t docbook -s | xsltproc transform.xsl - > middle.xml

considerations.xml:  considerations.mkd transform.xsl
	pandoc considerations.mkd -t docbook -s | xsltproc transform.xsl - > considerations.xml

back.xml:  back.mkd transform.xsl
	pandoc back.mkd -t docbook -s | xsltproc transform.xsl - > back.xml

draft.txt:	abstract.xml introduction.xml middle.xml considerations.xml back.xml template.xml
	DISPLAY= xml2rfc template.xml draft.txt

draft.html:	abstract.xml introduction.xml middle.xml considerations.xml back.xml template.xml
	DISPLAY= xml2rfc template.xml draft.html

$(DRAFTNAME).txt:	draft.txt
	ln -f -s $< $(DRAFTNAME).txt

$(DRAFTNAME).html:	draft.html
	ln -f -s $< $(DRAFTNAME).html

nits:   $(DRAFTNAME).txt
	idnits --year 2011 --verbose $<

clean:
	rm -f abstract.xml introduction.xml middle.xml considerations.xml back.xml

realclean: clean
	rm -f $(DRAFTNAME).txt $(DRAFTNAME).html draft.txt draft.html
