#!/usr/bin/env bash

set -x

gem install bundler -v 1.16.1 && bundle config --global path /tmp/bundle && bundle config --global bin /tmp/bundle/bin

gem update --system 2.6.14

bundle install --system --gemfile=directory_one/Gemfile && bundle install --system --gemfile=directory_two/Gemfile

bundle --version

bundle config

pushd directory_one
  # does not fail
  echo hello | bundle exec lolcat
popd
