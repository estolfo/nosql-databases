require 'mongo'

client = Mongo::Client.new(["localhost:27017"], database: :test)
puts client[:sales].count("items.fruit" => "banana")
