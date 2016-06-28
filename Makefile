JEKYLL=jekyll
JEKYLLOPTS=

OUTPUTDIR=$(CURDIR)/_site

help:
	@echo 'Makefile for a pelican Web site                                        '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make build                       (re)generate the web site          '
	@echo '   make check                       check everything is correct        '
	@echo '   make clean                       remove the generated files         '
	@echo '   make publish                     upload the web site via gh-pages   '
	@echo '   make serve                       serve site at http://localhost:4000'
	@echo '                                                                       '


build: clean
	$(JEKYLL) $(JEKYLLOPTS) build
	@echo 'Done'

check:
	$(JEKYLL) $(JEKYLLOPTS) doctor

clean:
	$(JEKYLL) $(JEKYLLOPTS) clean

serve:
	$(JEKYLL) $(JEKYLLOPTS) serve

publish: build
	ghp-import $(OUTPUTDIR)
	git push origin gh-pages

.PHONY: help build check clean serve publish
