#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

SITEURL = 'http://localhost:8000'
SITENAME = u'Cenando a las Nueve'

TIMEZONE = 'Europe/Madrid'

STATIC_PATHS = ["fotos",]
DEFAULT_LANG = u'es'

LOCALE  = ('es_ES' )

DEFAULT_DATE = 'fs'
USE_FOLDER_AS_CATEGORY = True

THEME = 'pelican-bootstrap3'
BOOTSTRAP_THEME = 'cerulean'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None

