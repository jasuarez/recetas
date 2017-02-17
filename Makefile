JEKYLL=bundle exec jekyll
JEKYLLOPTS=

OUTPUTDIR=$(CURDIR)/_site

SRCIMGDIR=$(CURDIR)/_img
DSTIMGDIR=$(CURDIR)/img

SRCIMGS := $(wildcard $(SRCIMGDIR)/*.jpg)
DSTIMG500S := $(SRCIMGS:$(SRCIMGDIR)/%.jpg=$(DSTIMGDIR)/%-500w.jpg)
DSTIMG640S := $(SRCIMGS:$(SRCIMGDIR)/%.jpg=$(DSTIMGDIR)/%-640w.jpg)
DSTIMG970S := $(SRCIMGS:$(SRCIMGDIR)/%.jpg=$(DSTIMGDIR)/%-970w.jpg)
DSTIMGBACK1024S := $(SRCIMGS:$(SRCIMGDIR)/%.jpg=$(DSTIMGDIR)/%-back-1024w.jpg)
DSTIMGBACK1440S := $(SRCIMGS:$(SRCIMGDIR)/%.jpg=$(DSTIMGDIR)/%-back-1440w.jpg)
DSTIMGBACK1920S := $(SRCIMGS:$(SRCIMGDIR)/%.jpg=$(DSTIMGDIR)/%-back-1920w.jpg)

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

$(DSTIMG500S): $(DSTIMGDIR)/%-500w.jpg : $(SRCIMGDIR)/%.jpg
	@echo "Creating $@"
	@convert $< -resize 500 $@

$(DSTIMG640S): $(DSTIMGDIR)/%-640w.jpg : $(SRCIMGDIR)/%.jpg
	@echo "Creating $@"
	@convert $< -resize 640 $@

$(DSTIMG970S): $(DSTIMGDIR)/%-970w.jpg : $(SRCIMGDIR)/%.jpg
	@echo "Creating $@"
	@convert $< -resize 970 $@

$(DSTIMGBACK1024S): $(DSTIMGDIR)/%-back-1024w.jpg : $(SRCIMGDIR)/%.jpg
	@echo "Creating $@"
	@convert $< -gravity North -crop 85%x45+0+30% +repage		\
		-resize 1024x341\^ -extent 1024x341 -gravity South	\
		-crop 1024x341+0+0 -grayscale rec601luma +level 10%,35%  $@

$(DSTIMGBACK1440S): $(DSTIMGDIR)/%-back-1440w.jpg : $(SRCIMGDIR)/%.jpg
	@echo "Creating $@"
	@convert $< -gravity North -crop 85%x45+0+30% +repage		\
		-resize 1440x480\^ -extent 1440x480 -gravity South	\
		-crop 1440x480+0+0 -grayscale rec601luma +level 10%,35%  $@

$(DSTIMGBACK1920S): $(DSTIMGDIR)/%-back-1920w.jpg : $(SRCIMGDIR)/%.jpg
	@echo "Creating $@"
	@convert $< -gravity North -crop 85%x45+0+30% +repage		\
		-resize 1920x640\^ -extent 1920x640 -gravity South	\
		-crop 1920x640+0+0 -grayscale rec601luma +level 10%,35%  $@

imgfront: $(DSTIMG500S) $(DSTIMG640S) $(DSTIMG970S)

imgback: $(DSTIMGBACK1024S) $(DSTIMGBACK1440S) $(DSTIMGBACK1920S)

img:
	mkdir img

images: img imgfront imgback

init:
	bundle install

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
	ghp-import $(OUTPUTDIR)
	git push origin gh-pages

.PHONY: help init build check clean serve publish images imgfront imgback
