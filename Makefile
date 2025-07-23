JEKYLL=bundle exec jekyll
JEKYLLOPTS=

OUTPUTDIR=$(CURDIR)/_site

help:
	@echo 'Makefile for a pelican Web site                                        '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make init                        install Jekyll and dependencies    '
	@echo '   make build                       (re)generate the web site          '
	@echo '   make check                       check everything is correct        '
	@echo '   make clean                       remove the generated files         '
	@echo '   make publish                     upload the web site via gh-pages   '
	@echo '   make serve                       serve site at http://localhost:4000'
	@echo '                                                                       '

img/500: _img
	@echo "Creating $@"
	@mkdir -p $@
	@mogrify -path $@  -resize 500 $</*.jpg

img/640: _img
	@echo "Creating $@"
	@mkdir -p $@
	@mogrify -path $@  -resize 640 $</*.jpg

img/970: _img
	@echo "Creating $@"
	@mkdir -p $@
	@mogrify -path $@  -resize 970 $</*.jpg

img/back/1024: _img
	@echo "Creating $@"
	@mkdir -p $@
	@mogrify -path $@ -gravity North -crop 85%x45+0+30% +repage	\
		-resize 1024x341\^ -extent 1024x341 -gravity South	\
		-crop 1024x341+0+0 -grayscale rec601luma +level 10%,35%	\
		$</*.jpg

img/back/1440: _img
	@echo "Creating $@"
	@mkdir -p $@
	@mogrify -path $@ -gravity North -crop 85%x45+0+30% +repage	\
		-resize 1440x480\^ -extent 1440x480 -gravity South	\
		-crop 1440x480+0+0 -grayscale rec601luma +level 10%,35%	\
		$</*.jpg

img/back/1920: _img
	@echo "Creating $@"
	@mkdir -p $@
	@mogrify -path $@ -gravity North -crop 85%x45+0+30% +repage	\
		-resize 1920x640\^ -extent 1920x640 -gravity South	\
		-crop 1920x640+0+0 -grayscale rec601luma +level 10%,35%	\
		$</*.jpg

images: img/500 img/640 img/970 img/back/1024 img/back/1440 img/back/1920

init:
	mkdir -p vendor
	npm install --prefix ./vendor bower
	./vendor/node_modules/.bin/bower install
	bundle config set path 'vendor'
	bundle install
	python3 -m venv vendor
	./vendor/bin/pip install ghp-import

build: clean images
	$(JEKYLL) $(JEKYLLOPTS) build
	@echo 'Done'

check:
	$(JEKYLL) $(JEKYLLOPTS) doctor

clean:
	$(JEKYLL) $(JEKYLLOPTS) clean

serve: images
	$(JEKYLL) $(JEKYLLOPTS) serve

publish: build
	./vendor/bin/ghp-import -n -p -f $(OUTPUTDIR)

.PHONY: help init build check clean serve publish images
