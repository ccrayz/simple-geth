#!/bin/bash

GETH_DATADIR="./data/geth"
PRYSM_DATADIR="./data/prysm"
CONFIG_DATADIR="./data/config"

if [[ ! -e ".env" ]]; then
    touch .env
    # setup your host data directory
    echo "GETH_DATADIR=$GETH_DATADIR" >> .env
    echo "PRYSM_DATADIR=$PRYSM_DATADIR" >> .env
    echo "CONFIG_DATADIR=$CONFIG_DATADIR" >> .env
fi

if [[ ! -d "./data" ]]; then
    mkdir -p $GETH_DATADIR $PRYSM_DATADIR $CONFIG_DATADIR
    openssl rand -hex 32 | tr -d "\n" > "$CONFIG_DATADIR/jwt.hex"
    curl -o $CONFIG_DATADIR/genesis.ssz -LJO https://github.com/eth-clients/holesky/raw/main/custom_config_data/genesis.ssz
fi

echo "Done!"
