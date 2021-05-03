#language: pt

Funcionalidade: Cadastro de Anúncios
  Sendo um usuário cadastrado no Rocklov que possui equipamentos musicais
  Quero cadastrar meus equipamentos
  Para que eu possa disponibiliza-los para locação

  Contexto: Login
    * Login com "davis@gmail.com" e "pwd123"

  Cenário: Novo equipamento
    Dado que acesso o formulário de cadastro de equipamentos
      E que eu tenho o seguinte equipamento:
      | thumb     | fender-sb.jpg |
      | nome      | Fender Strato |
      | categoria | Cordas        |
      | preco     | 200           |
    Quando submeter o cadastro desse item
    Entao devo ver esse item no meu dashboard

  @foto
  Esquema do Cenário: Tentativa de cadastro de equipamento
    Dado que acesso o formulário de cadastro de equipamentos
      E que eu tenho o seguinte equipamento:
      | thumb     | <foto>      |
      | nome      | <nome>      |
      | categoria | <categoria> |
      | preco     | <preco>     |
    Quando submeter o cadastro desse item
    Então deve conter a mensagem "<mensagem_saida>"

    Exemplos:
      | foto       | nome          | categoria | preco | mensagem_saida                       |
      |            | Clarinete     | Outros    | 150   | Adicione uma foto no seu anúncio!    |
      | baixo.jpg  |               | Cordas    | 200   | Informe a descrição do anúncio       |
      | amp.jpg    | Amplificador  |           | 120   | Informe a categoria                  |
      | pedais.jpg | Pedal Sustain | Outros    |       | Informe o valor da diária            |
      | conga.jpg  | Conga         | Outros    | abc   | O valor da diária deve ser numérico! |
      | conga.jpg  | Conga         | Outros    | 100c  | O valor da diária deve ser numérico! |