import requests
import subprocess
import pickle
from bs4 import BeautifulSoup


def get_quote():

    # get date of the day
    process = subprocess.run(['date', '+%e'],
                             stdout=subprocess.PIPE,
                             universal_newlines=True)
    day_date = process.stdout

    f = open("/home/francois/.config/i3/i3pystatus/quote", "rb")
    page = pickle.load(f)
    soup = BeautifulSoup(page.content, 'html.parser')
    f.close()

    # retrieve date in the HTML code
    quote_date = 0
    quote_date = (soup.find('div', class_="qotdSubtInf")).text
    quote_date = quote_date.split()
    quote_date = quote_date[1].strip("th")

    if int(day_date) != int(quote_date):
        print("helo")
        # retrieve page HTML
        URL = 'https://www.brainyquote.com/quote_of_the_day'
        page = requests.get(URL)
        soup = BeautifulSoup(page.content, 'html.parser')

        # save the new HTML page
        f = open("/home/francois/.config/i3/i3pystatus/quote", "wb")
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
        quote = quote[0]
    return quote, author


print(get_quote())
