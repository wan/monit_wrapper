#!/bin/bash
set -eux
cd `dirname $0`
bundle install
bundle rspec
git pull --rebase origin master
git push origin master
bundle exec stove
./publish_docs.sh
