Dado('que acesso a página principal') do  
  @login.open
end

Quando('submeto minhas credenciais {string} e {string}') do |email, password|
  @login.with(email, password)
end

Quando('submeto minhas credenciais') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  user = table.hashes.first

  find("input[placeholder='Seu email']").set user[:email]
  find("input[placeholder='Sua senha secreta']").set user[:senha]
  click_button 'Entrar'  
end