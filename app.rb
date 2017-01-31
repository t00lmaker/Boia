require "sinatra"

require "sinatra/activerecord"

set :database, {adapter: "mysql2", database: "jbroca", user: "root", password: "root"}

class Usuario  < ActiveRecord::Base
   self.table_name = "usuario"
end
class Colaborador  < ActiveRecord::Base
   self.table_name = "colaborador"
   belongs_to :usuario
end
class Opcao < ActiveRecord::Base
  self.table_name = "opcao"
end
class Cardapio < ActiveRecord::Base
   self.table_name = "cardapio"
   belongs_to :colaborador
end
class Pedido < ActiveRecord::Base
   self.table_name = "pedido"
   belongs_to :colaborador
end

get '/' do
  users = Usuario.all
  for u in users
    puts u.nome
  end
  erb :index
end
