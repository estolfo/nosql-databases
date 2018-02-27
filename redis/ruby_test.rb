require 'redis'
require 'json'

redis = Redis.new

redis.set("username", "james.brown")
redis.get("username")

redis.set("foo", [1, 2, 3].to_json)
redis.get("foo")

JSON.parse(redis.get("foo")).class
