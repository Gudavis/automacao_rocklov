Dado('que acesso a página principal') do
  visit "/"
end

Quando('submeto minhas credenciais {string} e {string}') do |email, senha|  
  login = LoginPage.new
  login.abrir
  login.campo_email.set email
  login.campo_senha.set senha
  login.botao_entrar
end

Quando('submeto minhas credenciais') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  user = table.hashes.first

  find("input[placeholder='Seu email']").set user[:email]
  find("input[placeholder='Sua senha secreta']").set user[:senha]
  click_button 'Entrar'  
end