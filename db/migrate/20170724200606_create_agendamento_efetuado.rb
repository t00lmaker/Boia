class CreateAgendamentoEfetuado < ActiveRecord::Migration[5.0]
  def change
    create_table :agendamento_efetuado do |t|
      t.boolean :notificado
      t.integer :idPedido
      t.date    :data_notificacao
      t.timestamps
    end
  end
end
