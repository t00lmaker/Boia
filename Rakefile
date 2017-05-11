require "sinatra/activerecord/rake"
require "./app"

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
