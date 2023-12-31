#!/bin/sh
set -e

rm -f tmp/pids/server.pid

bundle check || bundle install

bundle exec rails db:setup

bundle exec rails s -p 3000 -b 0.0.0.0
