#!/usr/bin/env bash

set -x

bundle --version

bundle config

pushd directory_one
  # should not fail !
  echo hello | bundle exec lolcat
popd
