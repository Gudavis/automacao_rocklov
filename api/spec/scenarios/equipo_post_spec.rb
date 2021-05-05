describe "POST /equipos" do
  before(:all) do
    payload = {
      email: "davis@gmail.com",
      password: "pwd123",
    }
    response = Session.new.login(payload)
    @user_id = response.parsed_response["_id"]
  end

  context "should create a new equipo" do
    before(:all) do
      payload = {
        thumbnail: Helpers::get_thumbnail("kramer.jpg"),
        name: "Kramer",
        category: "Cordas",
        price: 299,
      }

      MongoDB.new.remove_equip(payload[:name], @user_id)

      @response = Equipos.new.create(payload, @user_id)
    end

    it "should return status code 200" do
      expect(@response.code).to eq 200
    end
  end

  context "should not create a new equipo without authorization" do
    before(:all) do
      payload = {
        thumbnail: Helpers::get_thumbnail("baixo.jpg"),
        name: "Baixo",
        category: "Cordas",
        price: 239,
      }

      @response = Equipos.new.create(payload, nil)
    end

    it "should return status code 401" do
      expect(@response.code).to eq 401
    end
  end
end
