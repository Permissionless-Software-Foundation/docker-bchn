#!/bin/bash

# This file should be copied to the config directory mounted by the Docker
# container at startup. Edit this file to customize the environment variables
# controlling the infrastructure that the BCH ABC full node depends on.

cp /home/bitcoin/config/bitcoin.conf /data/bitcoin.conf

#CMD ["bitcoind", "-conf=/home/bitcoin/bitcoin.conf", "-datadir=/data", "-disablewallet"]
#CMD ["bitcoind", "-conf=/data/bitcoin.conf", "-datadir=/data", "-disablewallet"]

bitcoind -conf=/data/bitcoin.conf -datadir=/data -disablewallet
