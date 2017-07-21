configure :production, :development do
  ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "10.0.0.16",
  :username => "djair",
  :password => "rootinfoway",
  :database => "jbroca"
)
end
