prep:
	brew update
	brew install cask
	brew cask install pdftotext
	brew install ack

ex3:
	mkdir $@
	mkdir pdf-sources
	curl "http://graphics.wsj.com/hillary-clinton-email-documents/zips/HRC_Email_296.zip" -o pdf-sources/"HRC_Email_296.zip"
	unzip -d pdf-sources pdf-sources/HRC_Email_296.zip
	rm -f *.zip
	for file in pdf-sources/*.pdf; do pdftotext $$file; done
	for file in pdf-sources/*.txt; do mv $$file $@/$$(basename "$$file"); done

clear:
	rm -rf pdf-sources/