Dado('que acesso a página principal') do
  visit "/"
end

Quando('submeto minhas credenciais {string} e {string}') do |email, senha|
  find('#email').set email
  find('#password').set senha
  click_button 'Entrar'
end

Quando('submeto minhas credenciais') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  user = table.hashes.first

  find('#email').set user[:email]
  find('#password').set user[:senha]
  click_button 'Entrar'  
end