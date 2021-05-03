require_relative "routes/sessions"

describe "POST /sessions" do
  context "should create a new session" do
    before(:all) do
      payload = {
        email: "davis@gmail.com",
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

  examples = [
    {
      title: "invalid password",
      payload: {
        email: "davis@gmail.com",
        password: "pwd12345",
      },
      code: 401,
      error: "Unauthorized",
    },
    {
      title: "invalid email",
      payload: {
        email: "404@gmail.com",
        password: "pwd12345",
      },
      code: 401,
      error: "Unauthorized",
    },
    {
      title: "blank email field",
      payload: {
        email: "",
        password: "pwd12345",
      },
      code: 412,
      error: "required email",
    },
    {
      title: "removed email field",
      payload: {
        password: "pwd12345",
      },
      code: 412,
      error: "required email",
    },
    {
      title: "blank password field",
      payload: {
        email: "davis@gmail.com",
        password: "",
      },
      code: 412,
      error: "required password",
    },
    {
      title: "removed password field",
      payload: {
        email: "davis@gmail.com",
      },
      code: 412,
      error: "required password",
    },
  ]

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
