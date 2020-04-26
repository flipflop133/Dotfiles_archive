from i3pystatus import IntervalModule
import subprocess
import os
class custom_weather(IntervalModule):
	
	on_leftclick = "googleCalendar"
	settings = (
        "format",("interval", "update interval")
    )
	def getWeather(self):	
		process = subprocess.run(['curl', 'wttr.in/Saint-Léger,Belgium?format=1'],
						stdout=subprocess.PIPE, 
                        universal_newlines=True)
		output_list = (process.stdout).splitlines()
		if output_list == []:  # displays no internet and refresh every second
			cdict = {'weather':"no internet connexion",'interval':1}
			return cdict
		else:
			cdict = {'weather':output_list[0],'interval':600}
			return cdict

	def googleCalendar(self):
		os.popen("chromium https://www.meteo.be/fr/belgique")
	
	def run(self):
			cdict = self.getWeather()
			self.data = cdict
			self.output = {
				"full_text": self.format.format(**cdict),

			}
