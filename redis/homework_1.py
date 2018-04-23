import requests
url = 'https://api.nasa.gov/planetary/apod'
param = {'api_key' : 'mLATqV8OFmD0DSqwu1ckFscnNatKVYxDpndwZcOa','date' : '2017-09-12'}
r = requests.get(url, params = param)
j = r.json()
print(j["url"])
