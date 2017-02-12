require "sinatra/activerecord/rake"
require "pony"

namespace :db do
  task :load_config do
    require "./app"
  end
end

task :pedir_almoco do
  #agendamentos = Agendamento.where(ativo: true)
  #for (ag in agendamentos  )
#    pedido = Pedido.where(colaborador: ag.colaborador, data: Date.new)
#  end
end

task :enviar_email do
  Pony.mail({
  :to => 'luanpontes2@gmail.com',
  :body =>"<h1>hey there!</h1>",
  :from => "contato-no-reply@infoway-pi.com.br",
  :subject => 'Apresentacao Boia',
  :headers => { 'Content-Type' => 'text/html' },
  :via => :smtp,
  :via_options => {
    :address        => 'smtp.gmail.com',
    :port           => '465',
    :user_name      => 'contato-no-reply@infoway-pi.com.br',
    :password       => 'cnt-n0t-r3ply',
    :authentication => :plain
    }
  })
end
