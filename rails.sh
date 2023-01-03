#!/bin/bash

bundle check || bundle install

rm -f /rails-on-ecs/tmp/pids/server.pid

bundle exec rails s -p 3000 -b '0.0.0.0'