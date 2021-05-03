require "httparty"

class Session
  include HTTParty
  base_uri "http://rocklov-api:3333"

  def login(payload)
    return self.class.post(
             "/sessions",
             body: payload.to_json,
             headers: { "Content-type": "application/json" },
           )
  end
end
