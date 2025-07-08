OUTPUTDIR=$(CURDIR)/_site

help:
	@echo 'Makefile for a Eleventy Web site                                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make init                        install all dependencies           '
	@echo '   make build                       (re)generate the web site          '
	@echo '   make clean                       remove the generated files         '
	@echo '   make publish                     upload the web site via gh-pages   '
	@echo '   make serve                       serve site at http://localhost:8080'
	@echo '                                                                       '

init:
	npm install

build:
	npm run build

clean:
	rm -fr $(OUTPUTDIR)

serve:
	npm run dev

publish: build
	./vendor/bin/ghp-import -n -p -f $(OUTPUTDIR)

.PHONY: help init build clean serve publish
