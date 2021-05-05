describe "GET /equipos/{equipo_id}" do
  before(:all) do
    payload = {
      email: "davis@gmail.com",
      password: "pwd123",
    }
    response = Session.new.login(payload)
    @user_id = response.parsed_response["_id"]
  end
  context "should return only one equipo" do
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumbnail("sanfona.jpg"),
        name: "Sanfona",
        category: "Outros",
        price: 399,
      }

      MongoDB.new.remove_equip(@payload[:name], @user_id)

      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      @response = Equipos.new.find_by_id(@equipo_id, @user_id)
    end

    it "should return status code 200" do
      expect(@response.code).to eq 200
    end

    it "should return equipo name" do
      expect(@response.parsed_response).to include("name" => @payload[:name])
    end
  end

  context "should return equipo does not exist" do
    before(:all) do
      @response = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it "should return status code 404" do
      expect(@response.code).to eq 404
    end
  end
end

describe "GET /equipos" do
  before(:all) do
    payload = {
      email: "eita@gmail.com",
      password: "pwd123",
    }
    response = Session.new.login(payload)
    @user_id = response.parsed_response["_id"]
  end

  context "should return all equipos" do
    before(:all) do
      payloads = [
        {
          thumbnail: Helpers::get_thumbnail("sanfona.jpg"),
          name: "Sanfona",
          category: "Outros",
          price: 399,
        },
        {
          thumbnail: Helpers::get_thumbnail("clarinete.jpg"),
          name: "Clarinete",
          category: "Outros",
          price: 399,
        },
        {
          thumbnail: Helpers::get_thumbnail("slash.jpg"),
          name: "Slash",
          category: "Outros",
          price: 399,
        },
      ]

      payloads.each do |payload|
        MongoDB.new.remove_equip(payload[:name], @user_id)
        Equipos.new.create(payload, @user_id)
      end

      @response = Equipos.new.list(@user_id)
    end

    it "should return status 200" do
      expect(@response.code).to eql 200
    end

    it "should return an array of equipos" do
      expect(@response.parsed_response).not_to be_empty
    end
  end
end
