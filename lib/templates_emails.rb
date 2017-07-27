
class TemplatesEmails

  def notificacao_pedido(pedido)
    %{
      Olá, <br><br>
      eu sou o Boia e realizei o seu pedido conforme você me solicitou.
      As opções de seu pedido foram: #{pedido.opcao1.nome} e #{pedido.opcao2.nome}.
      <br>
      Peço perdão caso não tenha gostado do pedido, mas você pode alterar-lo no jBroca.
    }
  end

  def cardapio_nao_cadastrado()
    "Velho, o cádapio não foi cadastrado hoje."
  end

end
