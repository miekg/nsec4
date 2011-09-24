all:	draft.txt

abstract.xml: abstract.mkd
	pandoc abstract.mkd -t docbook -s | xsltproc transform.xsl - > abstract.xml

middle.xml: middle.mkd transform.xsl
	pandoc middle.mkd -t docbook -s | xsltproc transform.xsl - > middle.xml

back.xml:  back.mkd transform.xsl
	pandoc back.mkd -t docbook -s | xsltproc transform.xsl - > back.xml

draft.txt:	middle.xml back.xml abstract.xml template.xml
	DISPLAY= xml2rfc template.xml draft.txt

clean:
	rm -f middle.xml back.xml abstract.xml

realclean: clean
	rm -f draft.txt
