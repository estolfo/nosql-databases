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

function article_downvote(client, user, article) {
    // HOMEWORK 2
}

/*
var client = redis.createClient();
article_vote(client, "user:5", "article:0")
client.quit();
*/

// user x down votes article y
// user m down votes article y
// user n up votes article x
// zrange command to find "Easter egg" article