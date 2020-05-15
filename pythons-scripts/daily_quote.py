import requests
import subprocess
import pickle
from os.path import expanduser
from bs4 import BeautifulSoup


def get_quote():

    # get date of the day
    process = subprocess.run(['date', '+%e'],
                             stdout=subprocess.PIPE,
                             universal_newlines=True)
    day_date = process.stdout

    home = expanduser("~")
    quote_dir = home + '/.config/pythons-scripts/quote'
    quote_date = 0
    try:
        f = open(quote_dir, "rb")
        page = pickle.load(f)
        soup = BeautifulSoup(page.content, 'html.parser')
        f.close()

        # retrieve date in the HTML code
        quote_date = (soup.find('div', class_="qotdSubtInf")).text
        quote_date = quote_date.split()
        quote_date = quote_date[1].strip("th")
    except:
        pass
    if int(day_date) != int(quote_date):
        # retrieve page HTML
        URL = 'https://www.brainyquote.com/quote_of_the_day'
        page = requests.get(URL)
        soup = BeautifulSoup(page.content, 'html.parser')

        # save the new HTML page
        f = open(quote_dir, "wb")
        pickle.dump(page, f)
        f.close()

    # retrieve author and quote in the HTML code
    job_elems = soup.find_all('div', class_="mblCenterPhot")
    for job_elem in job_elems:
        quote = job_elem.find('img')
        quote = str(quote).split("=")
        quote = quote[1]
        quote = quote.split("\"")
        quote = quote[1].split("-")
        author = quote[1]
        quote = '“' + (quote[0]).strip() + '”'
    return quote, author


spaces = len(get_quote()[0])
print('''
   ''' + '_' * (spaces + 3) + '''
   |''' + ' ' * (spaces + 1) + '''|
   | ''' + get_quote()[0] + '''|
   | ''' + get_quote()[1] + ' ' * ((spaces) - len(get_quote()[1])) + '''|
   |''' + ' ' * (spaces + 1) + '''|
   ''' + '-' * (spaces + 3) + '''
''')
spaces = ' ' * 10
print(spaces + '    o')
print(spaces + '   o')
print(spaces + '  o')
print(spaces + ' o')
print(spaces + 'o')
print('''
      _      _                        
     : `.--.' ;              _....,_  
     .'      `.      _..--'"'       `-._
    :          :_.-'"                  .`.
    :  6    6  :                     :  '.;
    :          :                      `..';
    `: .----. :'                          ;
      `._Y _.'               '           ;
        'U'      .'          `.         ; 
           `:   ;`-..___       `.     .'`.
           _:   :  :    ```"''"'``.    `.  `.
         .'     ;..'            .'       `.'`
        `.......'              `........-'`                                         
''')