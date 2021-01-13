#language: pt

Funcionalidade: Cadastro de Anúncios
  Sendo um usuário cadastrado no Rocklov que possui equipamentos musicais
  Quero cadastrar meus equipamentos
  Para que eu possa disponibiliza-los para locação

  Cenário: Novo equipamento
    Dado que estou logado como "davis@gmail.com" e "pwd123"
      E que acesso o formulário de cadastro de equipamentos
      E que eu tenho o seguinte equipamento:
      | thumb     | fender-sb.jpg |
      | nome      | Fender Strato |
      | categoria | Cordas        |
      | preco     | 200           |
    Quando submeter o cadastro desse item
    Entao devo ver esse item no meu dashboard