require "sinatra/activerecord"

#configure :production do
  ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "10.0.0.16",
  :username => "jbroca",
  :password => "jbroca!@#1nf0",
  :database => "jbroca"
)
#end

#configure :development do
#  ActiveRecord::Base.establish_connection(
#  :adapter  => "mysql2",
#  :host     => "localhost",
#  :username => "root",
#  :password => "root",
#  :database => "jbroca2"
#)
#end
