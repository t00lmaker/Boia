require "sinatra"
require 'net/smtp'
require 'sinatra/flash'
require './config/environments'
require './models'

enable :sessions
use Rack::Session::Cookie, :key => 'rack.session', :path => '/', :secret => 'csdknjkjvsaoj54465665'

set :show_exceptions, false
set :bind, '0.0.0.0'

error Exception do
  erb :error500
end

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
      puts "ID usuário: #{session[:id]}"
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
    @message = "Realize login para realizar o agendamento."
   redirect :login
 end
end

post '/save' do
  if(session[:id_agenda])
    @agenda = Agendamento.find(session[:id_agenda])
    @agenda.ativo = false
    @agenda.save
    flash[:ok] = "Ok! Seu agendamento foi salvo."
  end
  puts "USUARIO: #{session[:id_agenda]}"
  @agenda = Agendamento.new(params)
  @agenda.created_at = Time.now
  @agenda.colaborador = Colaborador.where(usuario: Usuario.find(session[:id])).first
  @agenda.ativo = true
  if(@agenda.save)
     flash[:ok] = "Ok! Seu agendamento foi salvo."
  else
     flash[:erro] = "Ops, tivemos algum problema ao salvar seu agendamento."
  end
  redirect :agenda
end
