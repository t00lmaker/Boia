require "sinatra"

require "sinatra/activerecord"

set :database, {adapter: "mysql2", database: "jbroca", user: "root", password: "root"}

class Usuario  < ActiveRecord::Base
   self.table_name = "usuario"
end
class Colaborador  < ActiveRecord::Base
   self.table_name = "colaborador"
   belongs_to :usuario, :foreign_key => 'idUsuario', :primary_key => 'idUsuario'
end
class Opcao < ActiveRecord::Base
  self.table_name = "opcao"
end
class Cardapio < ActiveRecord::Base
   self.table_name = "cardapio"
end
class Pedido < ActiveRecord::Base
   self.table_name = "pedido"
   belongs_to :colaborador, :foreign_key => 'idColaborador', :primary_key => 'id'
end

get '/' do
  pedidos = Pedido.all
  for p in pedidos
    if(p.colaborador)
      puts p.colaborador.usuario.nome
    end
  end
  erb :index
end
