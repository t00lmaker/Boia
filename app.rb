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
   belongs_to :opcao1, :class_name => Opcao, :foreign_key => 'carne1', :primary_key => 'id'
   belongs_to :opcao2, :class_name => Opcao, :foreign_key => 'carne2', :primary_key => 'id'
   belongs_to :arroz,  :class_name => Opcao, :foreign_key => 'arroz',  :primary_key => 'id'
   belongs_to :salada, :class_name => Opcao, :foreign_key => 'salada', :primary_key => 'id'
end

class Agendamento < ActiveRecord::Base
  #self.table_name = "agendamento"
  #belongs_to :colaborador, :foreign_key => 'idColaborador', :primary_key => 'id'
end

get '/' do
  pedidos = Pedido.all
  for p in pedidos
    puts p.opcao1.nome
    puts p.opcao2.nome
    puts p.arroz.nome
    puts p.salada.nome
  end
  erb :index
end
