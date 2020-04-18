import subprocess
def getQuote():	
	process = subprocess.run(['wget', '-O', '/home/francois/.config/i3/i3pystatus/quote', 'https://www.brainyquote.com/quote_of_the_day'],
						stdout=subprocess.PIPE, 
                        universal_newlines=True)
	with open('/home/francois/.config/i3/i3pystatus/quote', "r") as f:
		data = f.readlines()
	final_string = ""
	for i in data:
		if "oncl_q" in i:
			current_string = i
			if "alt" in current_string:
				final_string = current_string
	words = final_string.split("\"")
	quote=""
	for j in range(len(words)):
		if "alt=" in words[j]:
			quote = words[j+1]
	if quote == "":
		quote = "keep up coding"
	else:
		quote = quote.split('.')
		quote = quote[0] + '\n' + quote[1]
	return quote
print(getQuote())
