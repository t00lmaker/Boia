require "sinatra/activerecord/rake"
require "./app"
require 'pony'

namespace :db do
  task :load_config do
    require "./app"
  end
end

task :pedir_almoco do
  amanha = Time.now - (60 * 60 * 24)
  pedir_para = []
  agendamentos = Agendamento.where(ativo: true)
  pedidos = Pedido.where(data: amanha)
  colaboradores = pedidos.map(&:colaborador)
  cardapio = Cardapio.where(data:amanha, cancelado:false)
  for ag in agendamentos
    if(ag.pedir_hj?)
      if(!colaboradores.include?(ag.colaborador))
        pedido = Pedido.new
        pedido.data = amanha
        pedido.carne1 = cardapio.carnes[0]
        pedido.carne2 = cardapio.carnes[1]
        pedido.arroz = cardapio.arroz
        pedido.salada = cardapio.salada
        pedido.feijao = cardapio.feijao
        peiddo.farofa = cardapio.farofa
        pedido.save
      end
    end
  end
end

task :enviar_email do
  Pony.options = {
  :subject => "Apresentacao Boia",
  :body => "This is the body.",
  :headers => { 'Content-Type' => 'text/html' },
  :via => :smtp,
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'contato-no-reply@infoway-pi.com.br',
    :password             => 'cnt-n0t-r3ply',
    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    :domain               => "localhost.localdomain"
  }
}

Pony.mail(:to => 'djaircarvalho.dj7@gmail.com')
end
