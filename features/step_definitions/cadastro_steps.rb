Dado('que acesso a página de cadastro') do
  visit "http://rocklov-web:3000/signup"
end

Quando('submeto o seguinte formulário de cadastro:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  user = table.hashes.first

  MongoDB.new.remove_user(user[:email])

  find('#fullName').set user[:nome]
  find('#email').set user[:email]
  find('#password').set user[:senha]
  click_button  'Cadastrar'
end

Então('sou redirecionado para o Dashboard') do
  expect(page).to have_css '.dashboard'
  sleep 5 #temporarily
end

Quando('submeto o meu cadastro sem o nome') do
  find('#email').set Faker::Internet.free_email
  find('#password').set "pwd123"
  click_button  'Cadastrar'
end

Quando('submeto o meu cadastro sem o email') do
  find('#fullName').set "Gustavo Davis"
  find('#password').set "pwd123"
  click_button  'Cadastrar'
end

Quando('submeto o meu cadastro com email incorreto') do
  find('#fullName').set "Gustavo Davis"
  find('#email').set "gustavo$gmail.com"
  find('#password').set "pwd123"
  click_button  'Cadastrar'
end

Quando('submeto o meu cadastro sem a senha') do
  find('#fullName').set "Gustavo Davis"
  find('#email').set Faker::Internet.free_email
  click_button  'Cadastrar'
end

Então('vejo a mensagem de alerta: {string}') do |expect_alert|
  alert = find('.alert-dark')
  expect(alert.text).to eql expect_alert
end