import CodaClient
import time
import os

nACCOUNTS = 200

coda = CodaClient.Client(graphql_port=8000)

# Figure Out which key we should send with
wallets = coda.get_wallets()
print(wallets)
SENDER_KEY = wallets[0]["publicKey"]

for i in range(0, nACCOUNTS):
    #Create a new account
    wallet = coda.create_wallet()
    # Fund it with the sender key
    resp = coda.send_payment(to_pk = wallet, from_pk = SENDER_KEY, amount = 10, fee = 5, memo = "foo")
    # sleep for 90 seconds
    time.sleep(90)