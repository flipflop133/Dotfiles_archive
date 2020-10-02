import subprocess
import os


def getWeather():
    process = subprocess.run(
        ['curl', '-s', 'wttr.in/Namur,Belgium?format=1'],
        stdout=subprocess.PIPE,
        universal_newlines=True)
    output_list = (process.stdout).splitlines()
    if output_list == []:  # displays no internet and refresh every second
        cdict = {
            'weather': "no internet connexion",
        }
        return cdict['weather']
    else:
        cdict = {
            'weather': str(output_list[0]),
        }
        return cdict['weather']


def irm(self):
    os.popen("chromium https://www.meteo.be/fr/belgique")


print(getWeather())
