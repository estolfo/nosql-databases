#!/usr/bin.env python3
#Author: @mes2311

import requests

#Request photo on bday
r = requests.get("https://api.nasa.gov/planetary/apod?api_key=ECUEvWOYxpMumqYAhjQWadgEPYPjabM4xB6cPGNe&date=1997-06-04")
fields = r.text.split(",")

#print url
print(fields[-1][12:-4])


