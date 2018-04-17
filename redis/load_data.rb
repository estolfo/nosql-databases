require 'redis'
require 'json'

ARTICLES_FILE = "data/articles.json"
SCORES_FILE = "data/scores.json"
VOTES_FILE = "data/votes.json"

def setup_data(redis)
  redis.flushall

  articles_file = File.new(ARTICLES_FILE)
  articles = JSON.load(articles_file.read)
  articles.each_with_index do |article, id|
    article.each do |k, v|
      redis.hset("article:#{id}", k, v)
    end
  end
  puts "#{articles.size} articles loaded into the database as hashes."

  # set up time zset (the times that the articles were posted), key is 'time:'
  articles.each_with_index do |article, i|
    redis.zadd("time:", Time.now.to_f, "article:#{i}")
  end
  puts "#{articles.size} time stamps loaded into the database as a sorted set."

  # set up score zset (the scores that the articles have), key is score:
  scores_file = File.new(SCORES_FILE)
  scores = JSON.load(scores_file)
  scores.each do |article, score|
    redis.zadd("score:", score, article)
  end
  puts "#{scores.size} scores loaded into the database as a sorted set."

  # set up set, key is "voted:<article number>", values are user:<user id>
  votes_files = File.new(VOTES_FILE)
  votes = JSON.load(votes_files)

  votes.each do |article, users|
    article_id = article.split(':')[-1]
    users.each do |user|
      redis.sadd("voted:#{article_id}", user)
    end
  end
  puts "#{votes.size} voting histories loaded into the database as a set."
end

setup_data(Redis.new)