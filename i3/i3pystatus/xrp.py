# Retrieve the xrp price in dollars from coinmarketcap.
# Doc: https://coinmarketcap.com/api/documentation/v1/

import json
import os

from i3pystatus import IntervalModule
from requests import Session
from requests.exceptions import ConnectionError, Timeout, TooManyRedirects


class xrp_price(IntervalModule):

    color = "#ffffff"
    on_leftclick = "coinbase"
    settings = ("format", ("interval", "update interval"), "color")

    def get_xrp_price(self):
        url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
        parameters = {'start': '1', 'limit': '5000', 'convert': 'EUR'}
        f = open("/home/francois/.config/xrp_api_key.txt", "r")
        apiKey = f.read()
        f.close()
        headers = {
            'Accepts': 'application/json',
            'X-CMC_PRO_API_KEY': apiKey,
        }

        session = Session()
        session.headers.update(headers)

        try:
            response = session.get(url, params=parameters)
            data = json.loads(response.content)
            data = data["data"]
            for x in data:
                if x['id'] == 52:
                    price = x['quote']['EUR']['price']
            price = round(price, 3)
            cdict = {'price': price, 'interval': 600}
            return cdict
        except (ConnectionError, Timeout, TooManyRedirects) as e:
            cdict = {'price': e, 'interval': 1}

    def coinbase(self):
        os.popen("chromium https://www.coinbase.com/dashboard")

    def run(self):
        cdict = self.get_xrp_price()
        self.data = cdict
        self.output = {
            "full_text": self.format.format(**cdict),
            "color": self.color
        }
