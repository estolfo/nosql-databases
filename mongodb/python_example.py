import pymongo
from pymongo import MongoClient

client = MongoClient()
database = client.store

collection = database.sales
collection.find({"items.fruit": "banana"}).count()
