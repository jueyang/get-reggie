all: prep download unzipped txt

prep:
	brew update
	brew install cask
	brew cask install pdftotext
	brew install ack

download:
	curl "http://graphics.wsj.com/hillary-clinton-email-documents/zips/HRC_Email_296.zip" -o "HRC_Email_296.zip"

unzipped: HRC_Email_296.zip
	mkdir $@
	unzip -d $@ $<
	touch $@

txt: unzipped
	mkdir $@
	for file in $</*; do pdftotext $$file; done
	for file in $</*.txt; do mv $$file $@/$$(basename "$$file"); done

clear:
	rm -rf unzipped text