#!/bin/bash

# This startup script becomes part of the Docker image. It is used
# to grab the run-script from the persistant volume and run it.
# Edit the run-script.sh if you need to change the way SLPDB runs,
# including environment variables.
cp /home/bitcoin/config/run-script.sh /home/bitcoin/run-script.sh
cd /home/bitcoin



# Function that runs when the docker container recieves the SIGTERM signal.
stopBitcoind() {
  echo "Stopping bitcoind..."

  # Instruct bitcoind to shut down.
  bitcoin-cli -conf=/data/bitcoin.conf stop

  # Wait 5 seconds for bitcoind to do its thing.
  sleep 5

  echo "...bitcoind has exited."
}

#Trap SIGTERM
trap 'stopBitcoind' SIGTERM

# Start bitcoind with the run script. Execute it in the background.
./run-script.sh &

#Wait
wait $!
