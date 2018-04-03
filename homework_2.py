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

def article_downvote(redis, user, article):
    # HOMEWORK 2
    pass

##redis = redis.StrictRedis(host='localhost', port=6379, db=0)
##article_vote(redis, "user:5", "article:0")

# user x down votes article y
# user m down votes article y
# user n up votes article x
# zrange command to find "Easter egg" article
