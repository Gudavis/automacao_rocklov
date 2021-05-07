require "digest/md5"

require_relative "routes/signup"
require_relative "routes/sessions"
require_relative "routes/equipos"
require_relative "libs/mongo"
require_relative "helpers"

def to_md5(password)
  return Digest::MD5.hexdigest(password)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    users = [
      { name: "Roberto", email: "beto@gmail.com", password: to_md5("pwd123") },
      { name: "Davis", email: "davis@gmail.com", password: to_md5("pwd123") },
      { name: "Gus", email: "eita@gmail.com", password: to_md5("pwd123") },
      { name: "Eddy", email: "solicitante@gmail.com", password: to_md5("pwd123") },
      { name: "Ozzy", email: "anunciante@gmail.com", password: to_md5("pwd123") },
    ]

    MongoDB.new.drop_collection
    MongoDB.new.create_users(users)
  end
end
