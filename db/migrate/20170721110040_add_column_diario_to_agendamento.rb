class AddColumnDiarioToAgendamento < ActiveRecord::Migration[5.0]
  def change
   add_column :agendamento, :diario, :boolean, :default => false
  end
end
