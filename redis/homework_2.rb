require 'redis'

ONE_WEEK_IN_SECONDS = 7 * 86400
VOTE_SCORE = 432

def article_vote(redis, user, article)
  cutoff = Time.now - ONE_WEEK_IN_SECONDS

  unless Time.at(redis.zscore('time:', article)) < cutoff
    article_id = article.split(':')[-1]
    if redis.sadd('voted:' + article_id, user)
      redis.zincrby('score:', VOTE_SCORE, article)
      redis.hincrby(article, 'votes', 1)
    end
  end
end

#redis = Redis.new
#article_vote(redis, "user:5", "article:0")


def article_downvote(redis, user, article)
  # HOMEWORK 2
end

# user x down votes article y
# user m down votes article y
# user n up votes article x
# zrange command to find "Easter egg" article