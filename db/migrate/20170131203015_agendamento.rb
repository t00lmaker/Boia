require "sinatra/activerecord"

class AgendamentoMigrate < ActiveRecord::Migration[5.0]
  def change
    create_table :agendamentos do |t|
      t.boolean :ativo
      t.integer :tipo
      t.long    :idColaborador
      t.date    :data
    end
  end
end
