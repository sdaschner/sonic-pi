FROM ubuntu:16.04

MAINTAINER Joseph Burnett (josephburnett79@gmail.com)

ADD app/gui/html/sources.list /etc/apt/

RUN apt-get update \
 && apt-get install -y \
  curl \
  darkice \
  default-jre \
  icecast2 \
  jackd2 \
  libgit2-dev \
  python \
  sudo \
  wget

# TODO include in list before
RUN apt-get update && apt-get install -y \
     g++ ruby ruby-dev pkg-config git build-essential libjack-jackd2-dev \
     libsndfile1-dev libasound2-dev libavahi-client-dev libicu-dev \
     libreadline6-dev libfftw3-dev libxt-dev libudev-dev cmake libboost1.58-dev \
     libqwt-qt5-dev libqt5scintilla2-dev libqt5svg5-dev qt5-qmake qt5-default \
     qttools5-dev qttools5-dev-tools qtdeclarative5-dev libqt5webkit5-dev \
     qtpositioning5-dev libqt5sensors5-dev qtmultimedia5-dev libffi-dev \
     libqt5opengl5-dev curl python erlang-base

COPY *.md sonic-pi/
COPY *.html sonic-pi/
COPY run-debian-app sonic-pi/
COPY app sonic-pi/app/
COPY bin/ sonic-pi/bin/
COPY etc/ sonic-pi/etc/

RUN cd /sonic-pi/app/gui/qt && ./build-ubuntu-app
RUN LEIN_ROOT=1 cd /sonic-pi/app/gui/html && ./vendor/lein cljsbuild once

CMD /sonic-pi/app/server/ruby/bin/launch
