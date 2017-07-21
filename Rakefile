require "sinatra/activerecord/rake"
require "./app"
require "byebug"


namespace :db do
  task :load_config do
    require "./app"
  end
end

task :pedir_almoco do
  amanha = Time.now + (60 * 60 * 24)
  pedir_para = []
  agendamentos = Agendamento.where(ativo: true)
  pedidos = Pedido.where(data: amanha)
  colaboradores = pedidos.map(&:colaborador)
  byebug
  cardapio = Cardapio.where(data: amanha, cancelado: "\x00")
  for ag in agendamentos
    if(ag.pedir_hj?)
      if(!colaboradores.include?(ag.colaborador))
        pedido = Pedido.new
        pedido.data = amanha
        pedido.dataCadastro = Time.now
        pedido.colaborador = ag.colaborador
        pedido.carne1 = cardapio.carnes.first
        pedido.carne2 = cardapio.carnes.second
        pedido.arroz = cardapio.arroz.first
        pedido.salada = cardapio.salada.first
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
