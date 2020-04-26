import subprocess
def getQuote():	
	
	# open html website file
	with open('/home/francois/.config/i3/i3pystatus/quote', "r") as f:
		data = f.readlines()
	# retrieve the date in the html file
	date = ''
	for i in data:
		if "twitter:title" in i:
			date = i.split()
			for j in date:
				if 'th' in j:
					date = j.strip("th\">")
	# get date of the day
	process = subprocess.run(['date','+%e'],
						stdout=subprocess.PIPE, 
                        universal_newlines=True)
	day_date = process.stdout
	# check if date in the html file is the date of the day
	retrieve_quote = True
	if date == day_date.strip():
		retrieve_quote = False
	if retrieve_quote == True:
		# retrieve quote html website
		process = subprocess.run(['wget','-q', '-O', '/home/francois/.config/i3/i3pystatus/quote', 'https://www.brainyquote.com/quote_of_the_day'],
						stdout=subprocess.PIPE, 
                        universal_newlines=True)
	# retrieve the quote
	final_string = ""
	with open('/home/francois/.config/i3/i3pystatus/quote', "r") as f:
		data = f.readlines()
	final_string = ""
	date = ''
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
	# handle empty quote or internet errors
	if quote == "":
		quote = "keep up coding"
	else:
		quote = quote.split('.')
		quote = quote[0] + '\n' + quote[1]
		# handle strange characters
		quote = quote.replace('&#39;',"'")
	return quote
print(getQuote())
