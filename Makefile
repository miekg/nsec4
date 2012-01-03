DRAFTNAME=$(shell grep docName template.xml | sed -e 's/.*docName=\"//' -e 's/\">//')
XML=abstract.xml introduction.xml middle.xml considerations.xml iana.xml changelog.xml back.xml
RFC=DISPLAY= xml2rfc template.xml

all:	$(DRAFTNAME).txt $(DRAFTNAME).html $(DRAFTNAME).xml

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
	rm -f $(XML)

realclean: clean
	rm -f $(DRAFTNAME).txt $(DRAFTNAME).html $(DRAFTNAME).xml draft.txt draft.html draft.xml

uberclean: realclean
	rm draft-*
