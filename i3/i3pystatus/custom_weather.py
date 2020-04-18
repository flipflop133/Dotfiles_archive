from i3pystatus import IntervalModule
import subprocess
class custom_weather(IntervalModule):
	def getWeather():	
		process = subprocess.run(['curl', 'wttr.in/Saint-Léger,Belgium?format=3'],
						stdout=subprocess.PIPE, 
                        universal_newlines=True)
		output_list = (process.stdout).splitlines()
		if output_list == []:
			return "no internet connexion"
		else:
			return output_list
	
	format = getWeather()
	def run(self):
		self.output = {
            "full_text": self.format,
        }
