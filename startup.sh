#!/bin/bash

bundle install --without development test
rake db:migrate
whenever --update-crontab
whenever

RACK_ENV=production ruby app.rb -p 3000

