class EquiposPage
  include Capybara::DSL

  def create(equipo)
    page.has_css?("#equipoForm")

    upload(equipo[:thumb]) if equipo[:thumb].length > 0

    # $ busca por valores que terminam com a palavra equipamento dentro do input
    find("input[placeholder$=equipamento]").set equipo[:nome]
    select_category(equipo[:categoria]) if equipo[:categoria].length > 0
    # ^ busca por valores que começam com a palavra Valor dentro do input
    find("input[placeholder^=Valor]").set equipo[:preco]

    click_button "Cadastrar"
  end

  def upload(file_name)
    thumb = Dir.pwd + "/features/support/fixtures/images/" + file_name

    find("#thumbnail input[type=file]", visible: false).set thumb
  end

  def select_category(category)
    find("#category").find("option", text: category).select_option
  end
end
