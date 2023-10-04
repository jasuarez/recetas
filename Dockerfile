FROM ubuntu:focal

LABEL com.github.containers.toolbox="true" 

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install libcap2-bin git make npm ruby-bundler ruby2.7-dev imagemagick-6.q16 ghp-import
