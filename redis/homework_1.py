import urllib.request as request
url = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2016-10-21"
content = request.urlopen(url).read()
array = content.splitlines()
res = array[len(array)-2]
print(res[10:len(res)-1].decode("utf-8"))

