XML=abstract.xml body.xml back.xml
# Use the file `nl` to introduce newlines
BODY=introduction.mkd middle.mkd considerations.mkd iana.mkd changelog.mkd
RFC=xml2rfc template.xml

all: draft.txt draft.html draft.xml

body.mkd: $(BODY)
	> body.mkd
	for i in $(BODY); do cat $(BODY) >> body.mkd; echo >> body.mkd; done

%.xml:	%.mkd transform.xsl
	pandoc $< -t docbook -s | xsltproc transform.xsl - > $@

draft.txt: $(XML) template.xml
	$(RFC) -f $@ --text

draft.html: $(XML) template.xml
	$(RFC) -f $@  --html

draft.xml: $(XML) template.xml
	$(RFC) -f $@ --exp

nits:   $(DRAFTNAME).txt
	idnits --year 2013 --verbose $<

clean:
	rm -f $(XML) body.xml body.mkd

realclean: clean
	rm -f draft.txt draft.html draft.xml

uberclean: realclean
	rm draft-*
