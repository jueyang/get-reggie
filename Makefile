all: prep download txt

prep:
	brew update
	brew install cask
	brew cask install pdftotext
	brew install ack

ex2: pdf-sources
	mkdir $@
	mkdir $</flint
	curl "somcsprod2govm001.usgovcloudapp.net/files/snyder emails.pdf" -o $</flint
	for file in $</flint/*.pdf; do pdftotext $$file; done
	for file in $</flint/*.txt; do mv $$file $@/$$(basename "$$file"); done

ex3: pdf-sources
	mkdir $</hilary
	curl "http://graphics.wsj.com/hillary-clinton-email-documents/zips/HRC_Email_296.zip" -o $</hilary/"HRC_Email_296.zip"
	unzip -d $</hilary $</hilary/HRC_Email_296.zip
	for file in $</hilary/*.pdf; do pdftotext $$file; done
	for file in $</hilary/*.txt; do mv $$file $@/$$(basename "$$file"); done

clear:
	rm -rf pdf-sources/*.txt
	rm -rf pdf-sources/hilary