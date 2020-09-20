#!/bin/bash
docker run -it -v /mnt/usb/full-nodes/mainnet/blockchain-data/bch-mainnet-abc:/data -p 8332:8332 -p 8333:8333 christroutner/bitcoind-bch:0.19.07 bash
