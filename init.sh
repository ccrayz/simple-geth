#!/bin/bash

GETH_DATADIR="./data/geth"
BEACON_DATADIR="./data/beacon"
CONFIG_DATADIR="./data/config"
PROMETHEUS_DATADIR="./data/monitoring/prometheus"
GRAFANA_DATADIR="./data/monitoring/grafana"
INFLUXDB_DATADIR="./data/monitoring/influxdb"

if [[ ! -e ".env" ]]; then
    touch .env
    # setup your host data directory
    echo "GETH_DATADIR=$GETH_DATADIR" >> .env
    echo "BEACON_DATADIR=$BEACON_DATADIR" >> .env
    echo "CONFIG_DATADIR=$CONFIG_DATADIR" >> .env
    echo "PROMETHEUS_DATADIR=$PROMETHEUS_DATADIR" >> .env
    echo "GRAFANA_DATADIR=$GRAFANA_DATADIR" >> .env
    echo "INFLUXDB_DATADIR=$INFLUXDB_DATADIR" >> .env
fi

if [[ ! -d "./data" ]]; then
    mkdir -p $GETH_DATADIR $BEACON_DATADIR $CONFIG_DATADIR $PROMETHEUS_DATADIR $GRAFANA_DATADIR
    openssl rand -hex 32 | tr -d "\n" > "$CONFIG_DATADIR/jwt.hex"
    curl -o $CONFIG_DATADIR/genesis.ssz -LJO https://github.com/eth-clients/holesky/raw/main/custom_config_data/genesis.ssz
fi

echo "Done!"
