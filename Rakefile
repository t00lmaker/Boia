require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require "./app"
  end
end

task :pedir_almoco do
  agendamentos = Agendamento.where(ativo: true)
  for (ag in agendamentos  )
    pedido = Pedido.where(colaborador: ag.colaborador, data: Date.new)
  end
end
