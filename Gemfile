source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse(::URI.open('https://pages.github.com/versions.json').read)

gem 'github-pages', versions['github-pages']
gem 'github-pages-health-check'
gem 'json'
gem 'rb-inotify'
