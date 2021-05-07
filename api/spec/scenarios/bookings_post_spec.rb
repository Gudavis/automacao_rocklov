describe "POST /equipos/{equipo_id}/bookings" do
  before(:all) do
    payload = {
      email: "solicitante@gmail.com",
      password: "pwd123",
    }
    response = Session.new.login(payload)
    @locator_id = response.parsed_response["_id"]
  end
  context "should be able to rent a new equipo" do
    before(:all) do
      #dado que tenho um equipamento para locação já cadastrado
      login = Session.new.login({ email: "anunciante@gmail.com", password: "pwd123" })
      advertiser_id = login.parsed_response["_id"]

      payload = {
        thumbnail: Helpers::get_thumbnail("fender-sb.jpg"),
        name: "Fender",
        category: "Cordas",
        price: 150,
      }

      MongoDB.new.remove_equip(payload[:name], advertiser_id)

      equipo = Equipos.new.create(payload, advertiser_id)
      equipo_id = equipo.parsed_response["_id"]

      #quando solicito a locação desse equipamento
      @booking = Equipos.new.booking(equipo_id, @locator_id)
    end

    it "should return status 200" do
      expect(@booking.code).to eql 200
    end
  end
end
