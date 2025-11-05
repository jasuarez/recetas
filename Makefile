OUTPUTDIR=$(CURDIR)/_site
CNAME=cenandoalasnueve.terralan.org

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

#nvm:
	#nvm use --lts
init:
	npm install

build:
	npm run build

clean:
	rm -fr $(OUTPUTDIR)

serve:
	npm run dev

publish: build
	ghp-import -n -p -f -c $(CNAME) $(OUTPUTDIR)

.PHONY: help init build clean serve publish
