FROM ubuntu:16.04

LABEL maintainer="mail@sebastian-daschner.com"

ADD app/gui/html/sources.list /etc/apt/

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
     build-essential \
     cmake \
     curl \
     darkice \
     default-jre \
     erlang-base \
     g++ \
     git \
     icecast2 \
     jackd2 \
     libasound2-dev \
     libavahi-client-dev \
     libboost1.58-dev \
     libffi-dev \
     libfftw3-dev \
     libgit2-dev \
     libicu-dev \
     libjack-jackd2-dev \
     libqt5opengl5-dev \
     libqt5sensors5-dev \
     libqt5svg5-dev \
     libqt5webkit5-dev \
     libqwt-qt5-dev \
     libreadline6-dev \
     libsndfile1-dev \
     libudev-dev \
     libxt-dev \
     pkg-config \
     python \
     qt5-default \
     qt5-qmake \
     qtdeclarative5-dev \
     qtmultimedia5-dev \
     qtpositioning5-dev \
     qttools5-dev \
     qttools5-dev-tools \
     ruby \
     ruby-dev \
     sudo \
     wget

COPY *.md sonic-pi/
COPY *.html sonic-pi/
COPY run-debian-app sonic-pi/
COPY app sonic-pi/app/
COPY bin/ sonic-pi/bin/
COPY etc/ sonic-pi/etc/

RUN cd /sonic-pi/app/gui/qt && ./build-ubuntu-app
RUN LEIN_ROOT=1 cd /sonic-pi/app/gui/html && ./vendor/lein cljsbuild once

CMD /sonic-pi/app/server/ruby/bin/launch
