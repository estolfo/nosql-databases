require 'redis'
require 'erb'
require 'pry-nav'
require 'json'

ARTICLES_FILE = "data/articles.json"
SCORES_FILE = "data/scores.json"
VOTES_FILE = "data/votes.json"

def setup_data(redis)
  redis.flushall

  articles_file = File.new(ARTICLES_FILE)
  articles = JSON.load(ERB.new(articles_file.read).result)
  articles.each_with_index do |article, id|
    article.each do |k, v|
      redis.hset("article:#{id}", k, v)
    end
  end

  # set up time zset (the times that the articles were posted), key is 'time:'
  articles.each_with_index do |article, i|
    redis.zadd("time:", article[:time], "article:#{i}")
  end

  # set up score zset (the scores that the articles have), key is score:
  scores_file = File.new(SCORES_FILE)
  scores = JSON.load(ERB.new(scores_file.read).result)
  scores.each do |article, score|
    redis.zadd("score:", score, article)
  end

  # set up set, key is "voted:<article number>", values are user:<user id>
  votes_files = File.new(VOTES_FILE)
  votes = JSON.load(ERB.new(votes_files.read).result)

  votes.each do |article, users|
    article_id = article.split(':')[-1]
    users.each do |user|
      redis.sadd("voted:#{article_id}", user)
    end
  end
end

setup_data(Redis.new)