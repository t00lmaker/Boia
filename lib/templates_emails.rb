
class TemplatesEmails

  def notificacao_pedido(pedido)
    "Olá, <br/> O seu pedido do dia #{pedido.data.strftime("%d/%m/%Y")}"+
    "foi efetuado com sucesso, com #{pedido.opcao1.nome} e #{pedido.opcao2.nome}"
  end

end
