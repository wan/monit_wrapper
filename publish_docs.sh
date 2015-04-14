#!/bin/bash

set -euxo pipefail
bundle install
bundle exec yardoc
mkdir -p build
cd build
git clone git@github.com:clearstorydata-cookbooks/monit_wrapper.git
git checkout gh-pages


