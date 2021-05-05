describe "DELETE /equipos/{equipo_id}" do
  before(:all) do
    payload = {
      email: "davis@gmail.com",
      password: "pwd123",
    }
    response = Session.new.login(payload)
    @user_id = response.parsed_response["_id"]
  end
  context "should remove one equipo" do
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumbnail("pedais.jpg"),
        name: "Pedais",
        category: "Outros",
        price: 199,
      }

      MongoDB.new.remove_equip(@payload[:name], @user_id)

      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      @response = Equipos.new.remove_by_id(@equipo_id, @user_id)
    end

    it "should return status code 204" do
      expect(@response.code).to eq 204
    end
  end

  context "should try to remove equipo does not exist" do
    before(:all) do
      @response = Equipos.new.remove_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it "should return status code 204" do
      expect(@response.code).to eq 204
    end
  end
end
