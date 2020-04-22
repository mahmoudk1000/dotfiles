#!/usr/bin/env python
# -*- coding: utf-8 -*-

import urllib.request
import json
import datetime
from pathlib import Path

########################################################
# CONFIGURATION
########################################################
# UNITY   = f for fahrenheit, c for celsius or k for kelvin   
# API_KEY = free register in https://openweathermap.org
#           and get your token
# CITY    = your city name
# COUNTRY = your country abbreviation: us, ru, br, etc..
########################################################

UNITY    = "c"
API_KEY  = "YOUR OWN API"
CITY     = "YOUR TOWN"
COUNTRY  = "YOUR COUNTRY - ABBREVIATED e.g. nz for NEW ZEALAND"

########################################################
main_url = "http://api.openweathermap.org/data/2.5/weather?"
filtered_city = CITY.replace(" ", "%20")
url = main_url+"APPID={}&q={},{}".format(API_KEY,filtered_city,COUNTRY)
metrics = {"k":"&units=default","c":"&units=metric","f":"&units=imperial"}
for key,value in metrics.items():
    if UNITY == key:
        url += value
request = urllib.request.urlopen(url)
if request.status != 200:
    exit(0)
response = request.read()

j = json.loads(response.decode("utf-8"))
home = str(Path.home())
weather = open(home+"/.cache/weather.txt",'w+')
weather.write("city>"+j["name"]+"\n")
weather.write("country>"+j["sys"]["country"]+"\n")
weather.write("temp>"+str(j["main"]["temp"])+"\n")
weather.write("description>"+j["weather"][0]["description"].capitalize()+"\n")
weather.write("min>"+str(j["main"]["temp_min"])+"\n")
weather.write("max>"+str(j["main"]["temp_max"])+"\n")
weather.write("humidity>"+str(j["main"]["humidity"])+"\n")
weather.write("pressure>"+str(j["main"]["pressure"])+"\n")
weather.write("wind>"+str(j["wind"]["speed"])+"\n")
weather.write("update>"+datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')+"\n")

weather.close()
