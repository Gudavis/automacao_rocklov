describe "POST /sessions" do
  context "should create a new session" do
    before(:all) do
      payload = {
        email: "beto@gmail.com",
        password: "pwd123",
      }
      @response = Session.new.login(payload)
    end

    it "should receive status code 200" do
      expect(@response.code).to eql 200
    end

    it "should receive id with 24 characters" do
      expect(@response.parsed_response["_id"].length).to eql 24
    end
  end

  examples = Helpers::get_fixture("login")

  examples.each do |example|
    context "should not create a new session with #{example[:title]}" do
      before(:all) do
        @response = Session.new.login(example[:payload])
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
