from i3pystatus import IntervalModule
import subprocess
import os
import requests
from bs4 import BeautifulSoup


class weather_com(IntervalModule):

    color = "#000000"
    on_leftclick = "irm"
    settings = (("format", "Format string used for output."),
                ("color", "Standard color"), ("interval", "Update interval."))
    format = "{icon}{temp}"
    interval = 1000

    def get_weather(self):
        try:
            # retrieve page HTML
            URL = 'https://weather.com/en-BE/temps/aujour/l/9aef22e1a76778d3658a0ad05e4ef5f49e2e44e4404d6e8bbc8603616c162f96'
            page = requests.get(URL)
            soup = BeautifulSoup(page.content, 'html.parser')

            # retrieve temperature in HTML code
            job_elems = soup.find_all('div', class_='today_nowcard-temp')
            temp = job_elems[0]
            temp = temp.text
            temp = int(temp.strip('°'))

            # retrieve weather conditions in HTML code
            job_elems = soup.find_all('div', class_='today_nowcard-phrase')
            conditions = job_elems[0]
            conditions = (conditions.text).lower()

            # determine icon in function of the weather conditions and the hour
            # check the hour
            icon = ''
            hour = subprocess.run(['date', '+%H'],
                                  check=True,
                                  stdout=subprocess.PIPE,
                                  universal_newlines=True)
            hour = (hour.stdout).strip()
            # night icons
            if int(hour) > 22 or int(hour) < 7:
                if "cloud" in conditions:
                    icon = ''
                elif "sun" in conditions:
                    icon = ''
                elif "rain" in conditions:
                    icon = ''
            # day icons
            else:
                if "cloud" in conditions:
                    icon = ''
                elif "sun" in conditions:
                    icon = ''
                elif "rain" in conditions:
                    icon = ''
                elif "clear" in conditions:
                    icon = ''

            cdict = {"icon": icon, "temp": temp}
        except:
            cdict = {"icon": '', "temp": ''}
        return cdict
        # find weather condition in the file

    def irm(self):
        os.popen("chromium https://www.meteo.be/fr/belgique")

    def run(self):
        cdict = self.get_weather()
        self.data = cdict
        self.output = {
            "full_text": self.format.format(**cdict),
            "color": self.color
        }
