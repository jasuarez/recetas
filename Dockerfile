FROM ubuntu:22.04

LABEL com.github.containers.toolbox="true"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install libcap2-bin sudo git make npm ruby-bundler ruby-dev apt install python3.10-venv imagemagick vim
