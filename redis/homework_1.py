import requests
r = requests.get('https://api.nasa.gov/planetary/apod?api_key=NExKQorPJxmpWSCxVEifZJHta96iEReALroeJaH3', params={'date': '1995-08-22'})
r.status_code
print(r.json()['url'])
