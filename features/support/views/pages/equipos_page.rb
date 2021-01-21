class EquiposPage
  include Capybara::DSL

  def create(equipo)
    page.has_css?("#equipoForm")

    thumb = Dir.pwd + "/features/support/fixtures/images/" + equipo[:thumb]

    find("#thumbnail input[type=file]", visible: false).set thumb
    # $ busca por valores que terminam com a palavra equipamento dentro do input
    find("input[placeholder$=equipamento]").set equipo[:nome]
    find("#category").find("option", text: equipo[:categoria]).select_option
    # ^ busca por valores que começam com a palavra Valor dentro do input
    find("input[placeholder^=Valor]").set equipo[:preco]

    click_button "Cadastrar"
  end
end