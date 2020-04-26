# imports
from i3pystatus import IntervalModule
import subprocess
import os
import time
class power_menu(IntervalModule):
	on_leftclick = "powerMenu"
	def powerMenu(self):
		os.popen("~/.config/i3/power-menu.sh")
			
	def run(self):
		self.output = {
            "full_text": '',
            "color": "#02c39a",
        }

	
				
