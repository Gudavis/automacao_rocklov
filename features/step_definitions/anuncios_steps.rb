Dado('que estou logado como {string} e {string}') do |email, senha|
  @email = email

  visit "/"

  find('#email').set email
  find('#password').set senha
  click_button 'Entrar'
end

Dado('que acesso o formulário de cadastro de equipamentos') do
  sleep 5 #temp

  click_button "Criar anúncio"
  # checkpoint para garantir que foi para o local correto
  expect(page).to have_css "#equipoForm"
end

Dado('que eu tenho o seguinte equipamento:') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  @anuncio = table.rows_hash

  MongoDB.new.remove_equip(@anuncio[:nome], @email)
end

Quando('submeter o cadastro desse item') do
  thumb = Dir.pwd + "/features/support/fixtures/images/" + @anuncio[:thumb]

  find("#thumbnail input[type=file]", visible: false).set thumb
  # $ busca por valores que terminam com a palavra equipamento dentro do input
  find("input[placeholder$=equipamento]").set @anuncio[:nome]
  find("#category").find("option", text: @anuncio[:categoria]).select_option
  # ^ busca por valores que começam com a palavra Valor dentro do input
  find("input[placeholder^=Valor]").set @anuncio[:preco]

  click_button "Cadastrar"

  sleep 5 #temp
end

Entao('devo ver esse item no meu dashboard') do
  anuncios = find(".equipo-list")
  expect(anuncios).to have_content @anuncio[:nome]
  expect(anuncios).to have_content "R$#{@anuncio[:preco]}/dia"
end