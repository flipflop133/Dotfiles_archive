# Retrieve the xrp price in dollars from coinmarketcap.
# Doc: https://coinmarketcap.com/api/documentation/v1/

import json
from requests import Session


def get_xrp_price():
    url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
    parameters = {'start': '1', 'limit': '5000', 'convert': 'EUR'}
    with open("/home/francois/.config/xrp_api_key.json", "r") as read_file:
        data = json.load(read_file)

    api_key = data['key']
    xrp_amount = data['amount']
    currency = data['currency']
    if currency == "USD":
        symbol = ""
    elif currency == "EUR":
        symbol = " "
    else:
        symbol = ""
    headers = {
        'Accepts': 'application/json',
        'X-CMC_PRO_API_KEY': str(api_key),
    }

    session = Session()
    session.headers.update(headers)

    try:
        response = session.get(url, params=parameters)
        data = json.loads(response.content)
        data = data["data"]

        for x in data:
            if x['id'] == 52:
                price = x['quote'][currency]['price']
                percent = x['quote'][currency]['percent_change_24h']
        percent = round(percent, 2)
        if percent > 0:
            percent = str(percent) + '%'
        elif percent == 0:
            percent = str(percent) + ''
        else:
            percent = str(percent) + '%'
        wallet = round((float(xrp_amount) * float(price)), 2)
        price = round(price, 3)
        cdict = {'price': price, 'percent': percent, 'wallet': wallet}
        print("XRP {}{} {} {}ﰤ".format(price, symbol, percent, wallet))
    except (ConnectionError):
        print("XRP")
    return cdict


get_xrp_price()
