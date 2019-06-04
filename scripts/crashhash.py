#! /usr/bin/env python3

"""Extract and attempt to make a signature of an ocaml traceback"""

import glob
import os
import subprocess
import re
import hashlib
import sys

""" Wrap os tail call, doing it by hand was too hard"""
def tail(fileName, n):
    p=subprocess.Popen(['tail','-n',str(n), fileName], stdout=subprocess.PIPE)
    soutput,sinput=p.communicate()
    return soutput.decode('utf-8')

""" Only care about lines that start with the error condition - start of trace """
def find_error(string):
    output = ''
    for line in string.splitlines(True):
        if 'monitor.ml.Error' in line or len(output) >0:
            output += line
    return(output)

""" Mask out actual line numbers and collumns, generate a sig based on this """
def error_sig(string):
    output = ''
    for line in string.splitlines(True):
        if 'Called' in line or 'Raised' in line:
            line = re.sub("line (\d+), characters (\d+)-(\d+)", "line HIDDEN, characters HIDDEN", line)
        output += line
    sig = hashlib.md5(output.encode('utf-8')).hexdigest()
    return(sig)

logfiles=glob.glob('./test-*/coda.log')

for filename in logfiles:
    lastfew = tail(filename, 30)
    if 'monitor.ml.Error' in lastfew:
        print('Error Detected In File: %s' % filename)
        s = find_error(lastfew)
        print(s)
        sig = error_sig(s)
        print("Signature:", sig)
        sys.exit(1)
