import json
import requests
import time
from datetime import *
from pathlib import Path
home = str(Path.home())

error_time = 0


def error_handling():
    global error_time
    time.sleep(error_time)
    error_time += 10
    get_sunset_sunrise()


def get_sunset_sunrise():
    """Retrieve current sunset and sunrise from weatherapi.com
    """
    data = ""
    try:
        # retrieve data from json file
        with open(home + "/.config/Themes/settings.json", 'r') as read_file:
            data = json.load(read_file)
        url = data['url']
        key = data['key']
        parameters = data['parameters']
        # retrieve weather from weatherapi.com
        request = "{}?key={}&q={}".format(url, key, parameters)
        response = requests.get(request)
        data = json.loads(response.content)
        sunrise = datetime.strptime(
            data['forecast']['forecastday'][0]['astro']['sunrise'], '%I:%M %p')
        sunrise = (str(sunrise.time())[:-3]).replace(':', '')
        sunset = datetime.strptime(
            data['forecast']['forecastday'][0]['astro']['sunset'], '%I:%M %p')
        sunset = (str(sunset.time())[:-3]).replace(':', '')
        return sunrise, sunset
    except requests.ConnectionError:
        error_handling()
    except json.JSONDecodeError:
        print("error in weather_settings.json file")
    except Exception as e:
        print(e)
        error_handling()


print(get_sunset_sunrise())
