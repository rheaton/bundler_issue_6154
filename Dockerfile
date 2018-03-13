FROM ubuntu:14.04

RUN apt-get update && \
    apt-get -y install software-properties-common && \
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ trusty-backports universe" && \
    add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
      build-essential \
      bzip2 \
      curl \
      libqt4-dev \
      ntp \
      libcurl4-gnutls-dev \
      libpq-dev \
      libssl-dev \
      libxml2-dev \
      libxslt-dev \
      wget \
      zlib1g-dev \
      zip unzip \
      xvfb

ADD directory_one     /tmp/directory_one
ADD directory_two     /tmp/directory_two
ADD run_some_gems.sh  /tmp/run_some_gems.sh

# Install ruby
RUN curl -L -O https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz ;\
    tar -xzvf v0.6.0.tar.gz                                                     ;\
    cd ruby-install-0.6.0/                                                      ;\
    make install                                                                ;\
    ruby-install --jobs=2 --cleanup --system ruby 2.3.6 -- --disable-install-rdoc

ENV GEM_HOME /tmp/bundle
ENV PATH $GEM_HOME/bin:$PATH
ENV BUNDLE_APP_CONFIG $GEM_HOME

RUN gem update --system 2.6.14

RUN gem install bundler -v 1.15.3 && \
	  bundle config --global path "$GEM_HOME" && \
	  bundle config --global bin "$GEM_HOME/bin"

WORKDIR /tmp

RUN bundle install --system --gemfile=directory_one/Gemfile && \
    bundle install --system --gemfile=directory_two/Gemfile
