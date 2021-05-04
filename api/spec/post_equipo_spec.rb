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
      thumbnail = File.open(File.join(Dir.pwd, "spec/fixtures/images", "kramer.jpg"))

      payload = {
        thumbnail: thumbnail,
        name: "Kramer",
        category: "Cordas",
        price: 299,
      }

      @response = Equipos.new.create(payload, @user_id)
    end

    it "should return status code 200" do
      expect(@response.code).to eq 200
    end
  end
end
