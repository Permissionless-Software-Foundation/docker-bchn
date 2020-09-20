#!/bin/bash

# This startup script becomes part of the Docker image. It is used
# to grab the run-script from the persistant volume and run it.
# Edit the run-script.sh if you need to change the way SLPDB runs,
# including environment variables.
cp /home/bitcoin/config/run-script.sh /home/bitcoin/run-script.sh
cd /home/bitcoin
./run-script.sh
