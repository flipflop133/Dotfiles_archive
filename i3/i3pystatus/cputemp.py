# imports
import subprocess
import os
def getTemp():
	""" execute a command and extract temperature
    return
    ------
    sum: the temperature average of all cores (float)
    Version
    −−−−−−−
    specification: François Bechet (v.1 06/04/20)
    implementation: François Bechet (v.1 06/04/20)
    """
	nCores = subprocess.run("nproc",stdout=subprocess.PIPE)
	nCores = nCores.stdout
	nCores = int(nCores)//2
	listTemps = []
	for core in range(0,nCores):
		command = "sensors coretemp-isa-0000 | awk '/Core %i/{print $3}'"%(core)
		C_core = os.popen(command)
		C_core = C_core.read()
		CoreTemp = ""
		for i in range(len(C_core)):
			if C_core[i] == "+":
				for j in range(1,5):
					CoreTemp+=(C_core[i+j])
		listTemps.append(CoreTemp)

	sum = 0
	for i in listTemps:
		sum+=float(i)
	return sum//nCores
	
print(getTemp())

