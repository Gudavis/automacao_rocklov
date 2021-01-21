Dado('que estou logado como {string} e {string}') do |email, password|
  @email = email

  @login.open
  @login.with(email, password)
end

Dado('que acesso o formulário de cadastro de equipamentos') do
  @dashboard.goto_equipo_form
end

Dado('que eu tenho o seguinte equipamento:') do |table|  
  # table is a Cucumber::MultilineArgument::DataTable
  @anuncio = table.rows_hash

  MongoDB.new.remove_equip(@anuncio[:nome], @email)
end

Quando('submeter o cadastro desse item') do
  @equipos.create(@anuncio)
end

Entao('devo ver esse item no meu dashboard') do
  @dashboard.equipo_list
  expect(@dashboard.equipo_list).to have_content @anuncio[:nome]
  expect(@dashboard.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end