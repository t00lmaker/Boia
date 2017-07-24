require "sinatra/activerecord"


class Usuario  < ActiveRecord::Base
   self.table_name = "usuario"

   def logar(senha)
     puts ">> #{senha.to_s} = #{jhash(senha).to_s}"
     self.senha.to_s == jhash(senha).to_s
   end

   TWO_31 = 2 ** 31
   TWO_32 = 2 ** 32
   # gera hashcode java.
   def jhash(str)
     size = str.size
      hash = 0
      str.chars.each_with_index do |ch, i|
        hash += ch.ord * (31 ** (size-(i+1)))
        hash = hash % TWO_32 - TWO_31
      end
      hash
  end
end
class Colaborador  < ActiveRecord::Base
   self.table_name = "colaborador"
   belongs_to :usuario, :foreign_key => 'idUsuario', :primary_key => 'idUsuario'
end
class Opcao < ActiveRecord::Base
  self.table_name = "opcao"
end
class Cardapio < ActiveRecord::Base
   self.table_name = "cardapio"
   has_many :opcaoes, foreign_key: :idCardapio

   def carnes
     opcaoes.select{|op| op.tipoOpcao == 'CARNE'}
   end
   def arroz
     opcaoes.select{|op| op.tipoOpcao == 'ARROZ'}
   end
   def salada
     opcaoes.select{|op| op.tipoOpcao == 'SALADA'}
   end
end
class Pedido < ActiveRecord::Base
   self.table_name = "pedido"
   belongs_to :colaborador, :foreign_key => 'idColaborador', :primary_key => 'id'
   belongs_to :opcao1, :class_name => Opcao, :foreign_key => 'carne1', :primary_key => 'id'
   belongs_to :opcao2, :class_name => Opcao, :foreign_key => 'carne2', :primary_key => 'id'
   belongs_to :arroz,  :class_name => Opcao, :foreign_key => 'arroz',  :primary_key => 'id'
   belongs_to :salada, :class_name => Opcao, :foreign_key => 'salada', :primary_key => 'id'
end

class Agendamento < ActiveRecord::Base
  self.table_name = "agendamento"
  belongs_to :colaborador, :foreign_key => 'idColaborador', :primary_key => 'id'

  def pedir_hj?()
      amanha = Time.now + (60 * 60 * 24)
      self.ativo &&
      (self.diario ||
      (amanha.monday? && self.pedir_seg) ||
      (amanha.tuesday? && self.pedir_ter) ||
      (amanha.wednesday? && self.pedir_qua) ||
      (amanha.thursday? && self.pedir_qui) ||
      (amanha.friday? && self.pedir_sex))
  end

end

class AgendamentoEfetuado < ActiveRecord::Base
  self.table_name = "agendamento_efetuado"

  belongs_to :pedido, :class_name => Pedido, :foreign_key => :idPedido, :primary_key => :id
end
