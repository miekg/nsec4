DRAFTNAME=$(shell grep docName template.xml | sed -e 's/.*docName=\"//' -e 's/\">//')
XML=abstract.xml body.xml back.xml
# Use the file `nl` to introduce newlines
BODY=introduction.mkd nl middle.mkd nl considerations.mkd nl iana.mkd nl changelog.mkd
RFC=DISPLAY= xml2rfc template.xml

all:	$(DRAFTNAME).txt $(DRAFTNAME).html $(DRAFTNAME).xml

body.xml:	$(BODY) transform.xsl
	cat $(BODY) > body.mkd
	pandoc body.mkd  -t docbook -s | xsltproc transform.xsl - > body.xml

%.xml:	%.mkd transform.xsl
	pandoc $< -t docbook -s | xsltproc transform.xsl - > $@

draft.txt:	$(XML) template.xml
	$(RFC) $@

draft.html: 	$(XML) template.xml
	$(RFC) $@

draft.xml:	$(XML) template.xml
	perl single-xml template.xml > $@

$(DRAFTNAME).txt:	draft.txt
	ln -sf $< $@

$(DRAFTNAME).html:	draft.html
	ln -sf $< $@

$(DRAFTNAME).xml:	draft.xml
	ln -sf $< $@

nits:   $(DRAFTNAME).txt
	idnits --year 2011 --verbose $<

clean:
	rm -f $(XML) body.xml body.mkd

realclean: clean
	rm -f $(DRAFTNAME).txt $(DRAFTNAME).html $(DRAFTNAME).xml draft.txt draft.html draft.xml

uberclean: realclean
	rm draft-*
