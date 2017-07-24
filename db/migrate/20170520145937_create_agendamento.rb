class CreateAgendamento < ActiveRecord::Migration[5.0]
  def change
   create_table :agendamento do |t|
      t.boolean :ativo
      t.integer :tipo
      t.integer :idColaborador
      t.date    :data
      t.timestamps
    end
  end
end
