var redis = require('redis');

var ONE_WEEK_IN_SECONDS = 7 * 86400;
var ONE_WEEK_IN_MILLISECONDS = 1000 * ONE_WEEK_IN_SECONDS;
var VOTE_SCORE = 432;

function article_vote(client, user, article) {
    var cutoff = Date.now() - ONE_WEEK_IN_MILLISECONDS;
	
	// Get article update time
    client.zscore("time:", article, function(err, article_time){
	    
		// Add to set if within time frame
		if (! (1000*article_time < cutoff)) {
	        var article_id = article.split(':')[1];

			client.sadd('voted:' + article_id, user, function(err, numAdded){
				if(err){
					console.log("error is " + err);
					return;
				}
				
				// On successful addition, increment other data				
				if(numAdded){
					client.zincrby('score:', VOTE_SCORE, article);
	            	client.hincrby(article, 'votes', 1);
				}
			});
	    }		
	});


}

function article_switch_vote(client, user, from_article, to_article) {
    // HOMEWORK 2 Part I
}

var client = redis.createClient();

//Error handling
client.on("error", function (err) {
    console.log("Error " + err);
});

//Once connection to server is made, then execute puts/gets
client.on("connect", function () {
    console.log("Connection made... ");

	// user:3 up votes article:1
	article_vote(client, "user:3", "article:1");
	// user:3 up votes article:3
	article_vote(client, "user:3", "article:3");
	// user:2 switches their vote from article:8 to article:1
	article_switch_vote(client, "user:2", "article:8", "article:1");

	// Which article's score is between 10 and 20?
	// PRINT THE ARTICLE'S LINK TO STDOUT:
	// HOMEWORK 2 Part II
	// client.?(...., function(err, reply){

		// print client.?	

		// NOTE/HINT: This invocation of quit may need to be nested
		// inside another callback. Make sure it is the last to be invoked..		
	//	client.quit();			
	// });
});



