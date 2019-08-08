#! /usr/bin/env python3

""" pull local stats and post them to carbon-relay """

from datetime import datetime
import logging
import json
from os import environ
import sys
import codalib
import graphyte

if __name__ == "__main__":
    # Load sensitive config
    try:
        with open('/etc/testnet_config.json') as config_file:
            config = json.load(config_file)
            testnet = config['testnet']
    except IOError as error:
        print('Error opening secrets config:', error)
        sys.exit(1)

    # get stats
    stats = codalib.coda_status()

    gmetrics = graphyte.Sender('localhost', prefix='testnet.%s.stats' % testnet, log_sends=True)
    gmetrics.send('block_count', stats['blockchain_length'])
    gmetrics.send('peer_count', len(stats['peers']))
    gmetrics.send('account_count', stats['num_accounts'])
    gmetrics.send('user_commands', stats['user_commands_sent'])
