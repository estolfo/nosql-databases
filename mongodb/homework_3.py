from pymongo import MongoClient

db = MongoClient().test

# Part A
cursor = db.movies.find({"rated" : "NOT RATED", "genres" : "Short"})
for doc in cursor:
	db.movies.update({"_id" : doc["_id"]},{'$set':{"rated": "Pending rating"}});
# Part B
db.movies.insert_one({"title": "Vienna Waits For You","year": 2012, "countries": ["Austria", "Chile"],"genres": ["Short", "Comedy", "Horror", "Mystery"], "directors": ["Dominik Hartl"], "imdb": {"id":2171890, "rating":7.2, "votes":152}})

# Part C
db.movies.aggregate([{'$match':{"genres" : "Short"}},{'$group':{"total":{'$sum': 1}, "_id" : "Short"}}])

# Part D

db.movies.aggregate([{'$match':{"countries" : "Hungary", "rated" : "Pending rating"}},{'$group':{"count":{'$sum': 1}, "_id" : {"countries" : "Hungary", "rating": "Pending rating"}}}])

# Part E
db.A.insert({"title": "A","year": 2012})
db.A.insert({"title": "A","year": 2013})
db.A.insert({"title": "A","year": 2014})
db.A.insert({"title": "A","year": 2015})
db.B.insert({"title": "B","year": 2015})
db.B.insert({"title": "B","year": 2014})
db.B.insert({"title": "A","year": 2013})
db.B.insert({"title": "A","year": 2012})

result = db.B.aggregate([{
   '$lookup':
     {
       'from': "A",
       "localField": "title",
       "foreignField": "title",
       'as': "output"
     }
}])

print(list(result))
