#!/bin/bash
rake db:migrate
bundle install --without development test
ruby $APP_HOME/app.rb -p 3000


