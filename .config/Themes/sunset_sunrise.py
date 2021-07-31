import json
import requests
import time
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
        sunrise = data['forecast']['forecastday'][0]['astro']['sunrise']
        sunset = data['forecast']['forecastday'][0]['astro']['sunset']
        return sunrise[:5].replace(":", ""), sunset[:5].replace(":", "")
    except requests.ConnectionError:
        error_handling()
    except json.JSONDecodeError:
        print("error in weather_settings.json file")
    except Exception as e:
        print(e)
        error_handling()


print(get_sunset_sunrise())
