#language: pt

Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais "davis@gmail.com" e "pwd123"
        Então sou redirecionado para o Dashboard

    @tentativa_login
    Esquema do Cenario: Tentativa de login
        Dado que acesso a página principal
        Quando submeto minhas credenciais 
        |email        |senha        |
        |<email_input>|<senha_input>|
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
        |email_input    |senha_input|mensagem_output                 |
        |davis@gmail.com|123pws     |Usuário e/ou senha inválidos.   |
        |gustavo@bol.com|pwd123     |Usuário e/ou senha inválidos.   |
        |davis*gmail.com|pwd123     |Oops. Informe um email válido!  |
        |               |pwd123     |Oops. Informe um email válido!  |
        |davis@gmail.com|           |Oops. Informe sua senha secreta!|
