#!/usr/bin/env python3

import sys
import json
import subprocess

with open('sample_keypairs.json') as json_file:
    data = json.load(json_file)

    count = 0
    for keypair in data:
        print(keypair)

        # pub key
        with open('high%s.pub' % count, 'w') as f:
            f.write("%s\n" % keypair['public_key'])


        # private key
        cmd="/Users/jkrauska/bin/coda client wrap-key -privkey-path high%s" % (count)
        print(cmd)
        myinput = "%s\n" % (keypair['private_key'])
        myenv = {
            'CODA_PRIVKEY_PASS': 'testnet',
        }

        subprocess.run(cmd.split(),
            input=myinput.encode('utf-8'),
            env=myenv )

        if count > 50:
            sys.exit(1)


        count += 1
