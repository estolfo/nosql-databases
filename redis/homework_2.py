import redis
import datetime


ONE_WEEK_IN_SECONDS = 7 * 86400
VOTE_SCORE = 432

def article_vote(redis, user, article):
    cutoff = datetime.datetime.now() - datetime.timedelta(seconds=ONE_WEEK_IN_SECONDS)

    if not datetime.datetime.fromtimestamp(redis.zscore('time:', article)) < cutoff:
        article_id = article.split(':')[-1]
        if redis.sadd('voted:' + artical_id, user):
            redis.zincrby('score:', VOTE_SCORE, article)
            reids.hincrby(article, 'votes', 1)

def article_switch_vote(redis, user, from_article, to_article):
    # HOMEWORK 2 Part I
    pass

redis = redis.StrictRedis(host='localhost', port=6379, db=0)
# user:3 up votes article:1
article_vote(redis, "user:3", "article:1")
# user:3 up votes article:3
article_vote(redis, "user:3", "article:3")
# user:5 switches their vote from article:1 to article:0
article_switch_vote(redis, "user:2", "article:8", "article:1")

# Which article's score is between 10 and 20?
# PRINT THE ARTICLE'S LINK TO STDOUT:
# HOMEWORK 2 Part II
# article = redis.?
# print redis.?

