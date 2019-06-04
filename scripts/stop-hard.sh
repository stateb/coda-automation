#!/bin/bash

# Cleanup
echo "Stopping previous coda test net"
killall coda coda-kademlia exe
pkill -f tree.py
