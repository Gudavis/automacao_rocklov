describe "POST /signup" do
  context "Should create a new user" do
    before(:all) do
      payload = {
        name: "Teste",
        email: "teste@gmail.com",
        password: "pwd123",
      }

      MongoDB.new.remove_user(payload[:email])

      @response = Signup.new.create(payload)
    end

    it "should receive status code 200" do
      expect(@response.code).to eql 200
    end

    it "should receive id with 24 characters" do
      expect(@response.parsed_response["_id"].length).to eql 24
    end
  end

  context "should not create user with existing email" do
    before(:all) do
      payload = {
        name: "Gustavo",
        email: "gustavo@gmail.com",
        password: "pwd123",
      }
      MongoDB.new.remove_user(payload[:email])

      Signup.new.create(payload)
      @response = Signup.new.create(payload)
    end

    it "should receive status code 409" do
      expect(@response.code).to eql 409
    end

    it "should receive error message" do
      expect(@response.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  examples = Helpers::get_fixture("signup")
  examples.each do |example|
    context "should not create a new user #{example[:title]}" do
      before(:all) do
        @response = Signup.new.create(example[:payload])
      end

      it "should assert status code '#{example[:code]}'" do
        expect(@response.code).to eql example[:code]
      end

      it "should assert error message '#{example[:error]}'" do
        expect(@response.parsed_response["error"]).to eql example[:error]
      end
    end
  end
end
