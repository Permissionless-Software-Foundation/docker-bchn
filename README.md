# docker-bchn
A BCH full node based on the BCHN reference implementation.

This repository is a core piece of infrastructure used by the [Cash Stack](https://cashstack.info), is used to provide API service at [FullStack.cash](https://fullstack.cash), and is used in the construction of a [Cash Box](https://woodcashbox.com).

## Installation

- It's assumed that you are starting with a fresh installation of Ubuntu
LTS on a 64-bit machine. It's also assumed that you are installing as
a [non-root user with sudo privileges](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04).

- Install Docker on the host
system.

- Clone this repository in your home directory with the following command:

`git clone https://github.com/christroutner/docker-bchn`

- Create a two directories in the same directory `docker-bchn`. These will be
used to store configuration data and blockchain data. Call them:
  - `config`
  - `blockchain-data`

- Copy the [run-script.sh](run-script.sh) and [bitcoin.conf](bitcoin.conf) file
into the `config` directory you just created. Customize the bitcoin.conf file for
your own full node.

- Enter the `docker-bchn/mainnet` directory and build the container with this command:

  - `docker compose build --no-cache`

- Once that is done, start the container with this command:

  - `docker compose up -d`

- Check on the status of bitcoind as it syncs to the blockchain:

  - `docker logs --tail 20 -f bchn-main`

## Interaction

The full node can be interacted with via the command line interface (CLI) or the JSON RPC.

### CLI

To interact with the CLI interface of the full node, you must enter the Docker container:

- `docker exec -it bchn-main bash`

You must always reference the bitcoin.conf configuration file each time you issue a command:

- `bitcoin-cli -conf=/data/bitcoin.conf getnetworkinfo`
- `bitcoin-cli -conf=/data/bitcoin.conf getblockchaininfo`


### JSON RPC

Here are examples of using the *curl* command to manually interact with the JSON RPC.

`curl --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getnetworkinfo","params":[]}' -H 'content-type:text/plain;' http://bitcoin:password@127.0.0.1:8332/`

`curl --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getblockchaininfo","params":[]}' -H 'content-type:text/plain;' http://bitcoin:password@127.0.0.1:8332/`

### Customization
- Customize the `volumes` setting in the [docker-compose.yml](docker-compose.yml)
file in order to choose where you want the blockchain data and config files stored.

- Edit the bitcoin.conf file in the `config` directory and restart the container
if you need to change the configuration settings for the full node.

# License
[MIT License](LICENSE.md)
