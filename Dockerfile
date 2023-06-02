FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install git make npm ruby-bundler ruby2.7-dev imagemagick-6.q16 ghp-import
