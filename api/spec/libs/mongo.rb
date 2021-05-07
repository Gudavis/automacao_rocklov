require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB
  attr_accessor :users, :equipos, :client

  def initialize
    @client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def drop_collection
    client.database.drop
  end

  def create_users(docs)
    @users.insert_many(docs)
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def get_user(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  def remove_equip(name, user_id)
    object_id = BSON::ObjectId.from_string(user_id)
    equipos.delete_many({ name: name, user: object_id })
  end

  def get_mongo_id
    return BSON::ObjectId.new
  end
end
