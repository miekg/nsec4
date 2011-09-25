all:	draft-nsec4-00.txt draft-nsec4-00.html

middle.xml: middle.mkd transform.xsl
	pandoc middle.mkd -t docbook -s | xsltproc transform.xsl - > middle.xml

back.xml:  back.mkd transform.xsl
	pandoc back.mkd -t docbook -s | xsltproc transform.xsl - > back.xml

draft-nsec4-00.txt:	middle.xml back.xml template.xml
	DISPLAY= xml2rfc template.xml draft-nsec4-00.txt

draft-nsec4-00.html:	middle.xml back.xml template.xml
	DISPLAY= xml2rfc template.xml draft-nsec4-00.html

nits:   draft-nsec4-00.txt
	idnits --year 2011 --verbose $<

clean:
	rm -f middle.xml back.xml

realclean: clean
	rm -f draft-nsec4-00.txt
