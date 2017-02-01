require "sinatra"

require "sinatra/activerecord"

set :database, {adapter: "mysql2", database: "jbroca", user: "root", password: "root"}

enable :sessions

class Usuario  < ActiveRecord::Base
   self.table_name = "usuario"

   def logar(senha)
     self.senha.to_s == jhash(senha).to_s
   end

   TWO_31 = 2 ** 31
   TWO_32 = 2 ** 32
   # gera hashcode java.
   def jhash(str)
     size = str.size
      hash = 0
      str.chars.each_with_index do |ch, i|
        hash += ch.ord * (31 ** (size-(i+1)))
        hash = hash % TWO_32 - TWO_31
      end
      hash
  end
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
  self.table_name = "agendamento"
  belongs_to :colaborador, :foreign_key => 'idColaborador', :primary_key => 'id'
end

get '/' do
  erb :index
end

get '/login' do
  erb :index
end


post '/login' do
  user = Usuario.find_by_login(params[:usuario])
  if(user)
    if(user.logar(params[:senha]))
      redirect :agenda
    end
  end
  @message = "Não foi possível realizar login, verifique suas credenciais no JBroca."
  erb :index
end

get '/agenda' do
 erb :agenda
end
