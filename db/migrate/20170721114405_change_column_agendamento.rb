class ChangeColumnAgendamento < ActiveRecord::Migration[5.0]
  def change
   add_column :agendamento, :pedir_seg, :boolean, :default => false
   add_column :agendamento, :pedir_ter, :boolean, :default => false
   add_column :agendamento, :pedir_qua, :boolean, :default => false
   add_column :agendamento, :pedir_qui, :boolean, :default => false
   add_column :agendamento, :pedir_sex, :boolean, :default => false
  end
end
