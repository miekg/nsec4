all:	draft.txt

draft.xml: front.xml back.xml draft.pdc transform.xsl
	(cat front.xml; pandoc draft.pdc -t docbook -s | xsltproc transform.xsl -; cat back.xml) > draft.xml 

draft.txt: draft.xml
	xml2rfc draft.xml draft.txt

clean:
	rm -f draft.xml

realclean: clean
	rm -f draft.txt
