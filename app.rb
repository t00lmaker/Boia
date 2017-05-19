require "sinatra"
require "sinatra/activerecord"
require 'net/smtp'


class Usuario  < ActiveRecord::Base
   self.table_name = "usuario"

   def logar(senha)
     puts ">> #{senha.to_s} = #{jhash(senha).to_s}"
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
   has_many :opcoes

   def carnes
     opcaoes.select{|op| op.tipoOpcao == 'CARNE'}
   end
   def arroz
     opcaoes.select{|op| op.tipoOpcao == 'ARROZ'}
   end
   def salada
     opcaoes.select{|op| op.tipoOpcao == 'SALADA'}
   end
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

  def pedir_hj?()
      amanha = Time.now + (60 * 60 * 24)
      self.ativo &&
      (self.diario ||
      (amanha.monday? && self.pedir_seg) ||
      (amanha.tuesday? && self.pedir_ter) ||
      (amanha.wednesday? && self.pedir_qua) ||
      (amanha.thursday? && self.pedir_qui) ||
      (amanha.friday? && self.pedir_sex))
  end

end

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "10.0.0.16",
  :username => "jbroca",
  :password => "root!@#1nf0",
  :database => "jbroca"
)

# set :database, {host: '10.0.0.16', adapter: "mysql2", database: "jbroca", user: "jbroca", password: "root@1nf0"}
enable :sessions
get '/' do
  erb :index
end

get '/login' do
  erb :index
end

post '/login' do
  @user = Usuario.find_by_login(params[:usuario])
  if(@user)
    if(@user.logar(params[:senha]))
      session[:id] = @user.id
      redirect :agenda
    end
  end
  @message = "Não foi possível realizar login, verifique suas credenciais no JBroca."
  erb :index
end

get '/about' do
 erb :about
end

get '/logout' do
 session.clear
 redirect :login
end

get '/agenda' do
 if(session[:id])
   @colaborador = Colaborador.where(usuario: Usuario.find(session[:id])).first
   @agenda = Agendamento.where(colaborador:  @colaborador, ativo: true).last
   @agenda = Agendamento.new unless @agenda
   session[:id_agenda] = @agenda.id
   erb :agenda
 else
    session[id_agenda] = nil
    @message = "Realize login para realizar o a agendamento."
   redirect :login
 end
end

post '/save' do
  if(session[:id_agenda])
    @agenda = Agendamento.find(session[:id_agenda])
    @agenda.ativo = false
    @agenda.save
  end
  @agenda = Agendamento.new(params)
  @agenda.create_at = Time.now
  @agenda.colaborador = Colaborador.where(usuario: Usuario.find(session[:id])).first
  @agenda.ativo = true
  if(@agenda.save)
     @mensage = "Ok! Seu agendamento foi salvo."
  else
     @mensage = "Ops, tivemos algum problema ao salvar seu agendamento."
  end
  redirect :agenda
end
