draft.txt: *.mkd
	pandoc2rfc *.mkd

draft.xml: *.mkd
	pandoc2rfc -X *.mkd

draft.html: *.mkd
	pandoc2rfc -H *.mkd

.PHONY: clean

clean:
	rm -f draft.*
