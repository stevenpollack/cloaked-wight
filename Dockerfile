## mimic build on ubuntu 16.04
FROM ubuntu:16.04

MAINTAINER "Steven Pollack" steven@gnobel.com

RUN apt-get update && apt-get install -y \
    apt-utils \
    git \
    lsb-release \
    make \
    python3 \
    sudo 

RUN mkdir cloaked-wight
WORKDIR cloaked-wight
COPY . .

RUN make clean
RUN make .tmux.ind
RUN make .zsh.ind

ENTRYPOINT ["/bin/bash"]


