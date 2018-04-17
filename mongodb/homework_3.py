from pymongo import MongoClient

db = MongoClient().test

# Part A
cursor = db.movies.find({"rated" : "NOT RATED", "genres" : "Short"})
for doc in cursor:
	db.movies.update({"_id" : doc["_id"]},{'$set':{"rated": "Pending rating"}});
# Part B
db.movies.insert_one({"title": "Vienna Waits For You","year": 2012, "countries": ["Austria", "Chile"],"genres": ["Short", "Comedy", "Horror", "Mystery"], "directors": ["Dominik Hartl"], "imdb": {"id":2171890, "rating":7.2, "votes":152}})
for doc in db.movies.find({"title" : "Vienna Waits For You", "genres" : "Short"}):
	print(doc)
# Part C
for doc in db.movies.aggregate([{'$match':{"genres" : "Short"}},{'$group':{"total":{'$sum': 1}, "_id" : "Short"}}])

# Part D
