require "sinatra/activerecord"

#configure :production do
  ActiveRecord::Base.establish_connection(
  :adapter  => 
  :host     => 
  :username => 
  :password => 
  :database => 
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
