#!/bin/bash
rake db:migrate
bundle install --without development test
RACK_ENV=production ruby app.rb -p 3000
