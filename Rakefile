require "sinatra/activerecord/rake"
require "./app"
require 'pony'
require './lib/email_sender'
require './lib/templates_emails'
require './config/environments'
require 'byebug'

namespace :db do
  task :load_config do
    require "./app"
  end
end

task :pedir_almoco do
  amanha = Time.now + (60 * 60 * 24)
  agendamentos = Agendamento.where(ativo: true)
  pedidos = Pedido.where(data: amanha)
  colaboradores = pedidos.map(&:colaborador)
  cardapios = Cardapio.where(data: Time.now, cancelado: "\x00").to_a
  if(cardapios.empty?)
    sender = EmailSender.new
    t = TemplatesEmails.new
    sender.send('luan@infoway-pi.com.br', 'Boia - Cardápio não encontrado', t.cardapio_nao_cadastrado)
  else
    cardapio = cardapios.first
    for ag in agendamentos
      if(ag.pedir_hj?)
        if(!colaboradores.include?(ag.colaborador))
          pedido = Pedido.new
          pedido.data = amanha
          pedido.dataCadastro = Time.now
          pedido.colaborador = ag.colaborador
          pedido.opcao1 = cardapio.carnes.first
          pedido.opcao2 = cardapio.carnes.second
          pedido.arroz = cardapio.arroz.first
          pedido.salada = cardapio.salada.first
          pedido.save
          pedidoEfetuado = AgendamentoEfetuado.new
          pedidoEfetuado.pedido = pedido
          pedidoEfetuado.notificado = false
          pedidoEfetuado.save
        end
      end
    end
  end
end

task :enviar_email do
  sender = EmailSender.new
  t = TemplatesEmails.new
  agendamentos = AgendamentoEfetuado.includes(:pedido).where(notificado: false).to_a
  agendamentos.each do |a|
    p = Pedido.find(a.idPedido)
    sender.send(p.colaborador.email, 'Boia - Pedido de Almoço', t.notificacao_pedido(p))
    p.data_notificacao = Time.now
    p.notificado = true
    p.save
  end

end
