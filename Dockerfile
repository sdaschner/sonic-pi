FROM ubuntu:16.04

# TODO WIP
# moved from app/gui/html

MAINTAINER Joseph Burnett (josephburnett79@gmail.com)

ADD app/gui/html/sources.list /etc/apt/

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
  git \
  curl \
  darkice \
  default-jre \
  icecast2 \
  jackd2 \
  libgit2-dev \
  python \
  sudo \
  wget \
  ruby-dev \
  make \
  cmake \
  g++ \
  lbzip2 \
  pkg-config \
  libssl-dev \
  libasound2-dev \
  libavahi-client-dev \
  libicu-dev \
  libreadline6-dev \
  libfftw3-dev \
  libxt-dev \
  libudev-dev \
  libffi-dev \
  libsndfile1-dev \
  libx11-dev \
  libxt-dev \
  libjack-jackd2-dev \
  libqt5scintilla2-dev \
  libqt5sensors5-dev \
  libqt5svg5-dev \
  libqt5webkit5-dev \
  libqwt-qt5-dev \
  qt5-default \
  qt5-qmake \
  qtdeclarative5-dev \
  qtmultimedia5-dev \
  qtpositioning5-dev \
  qttools5-dev \
  qttools5-dev-tools

# install aubio
RUN wget http://aubio.org/pub/aubio-0.4.4.tar.bz2 \
 && tar -xf aubio-0.4.4.tar.bz2 \
 && cd aubio-0.4.4 \
 && ./waf configure build \
 && sudo ./waf install

# install supercollider
RUN wget https://github.com/supercollider/supercollider/releases/download/Version-3.9.2/SuperCollider-3.9.2-Source-linux.tar.bz2 \
 && tar -xf SuperCollider-3.9.2-Source-linux.tar.bz2 \
 && mkdir SuperCollider-Source/build/ \
 && cd SuperCollider-Source/build/ \
 && cmake -DSC_EL=no .. \
 && make install

# install osmid
RUN wget https://github.com/llloret/osmid/archive/v0.6.tar.gz \
 && tar -xf v0.6.tar.gz \
 && cd osmid-0.6 \
 && mkdir build && cd build \
 && cmake .. \
 && make \
 && make install

COPY run-debian-app sonic-pi/
COPY app sonic-pi/app/
COPY bin/ sonic-pi/bin/
COPY etc/ sonic-pi/etc/

RUN /sonic-pi/app/server/ruby/bin/compile-extensions.rb

COPY sonic-pi.sh /

#CMD ["/sonic-pi.sh"]
