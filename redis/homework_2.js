var redis = require('redis');

var ONE_WEEK_IN_SECONDS = 7 * 86400;
var ONE_WEEK_IN_MILLISECONDS = 1000 * ONE_WEEK_IN_SECONDS;
var VOTE_SCORE = 432;

function article_vote(client, user, article) {
    var cutoff = Date.now() - ONE_WEEK_IN_MILLISECONDS;
    var article_time = 1000 * client.zscore("time:", article);

    if (! article_time < cutoff) {
        var article_id = article.split(':')[1];
        if (client.sadd('voted:' + article_id, user)) {
            client.zincrby('score:', VOTE_SCORE, article);
            client.hincrby(articl, 'votes', 1);
        }
    }
}

function article_switch_vote(client, user, from_article, to_article) {
    // HOMEWORK 2 Part I
}

var client = redis.createClient();
// user:3 up votes article:1
article_vote(client, "user:3", "article:1")
// user:3 up votes article:3
article_vote(client, "user:3", "article:3")
// user:5 switches their vote from article:1 to article:0
article_switch_vote(client, "user:2", "article:8", "article:1")
client.quit();

// Which article's score is between 10 and 20?
// PRINT THE ARTICLE'S LINK TO STDOUT:
// HOMEWORK 2 Part II
// var article = client.?
// print client.?
