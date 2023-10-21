#!/bin/sh
set -exu

VERBOSITY=${GETH_VERBOSITY:-3}

GETH_DATA_DIR=/data
GETH_CHAINDATA_DIR="$GETH_DATA_DIR/chaindata"
GENESIS_FILE_PATH="${GENESIS_FILE_PATH:-/config/genesis.json}"
CHAIN_ID=${CHAIN_ID:-19941123}
RPC_PORT="${RPC_PORT:-8545}"
WS_PORT="${WS_PORT:-8546}"

# address
if [ ! -d "$GETH_CHAINDATA_DIR" ]; then
  echo "Initialize geth..."

  echo "[Geth] Initializing genesis"
  geth --verbosity="$VERBOSITY" init \
    --datadir="$GETH_DATA_DIR" \
    "$GENESIS_FILE_PATH"

  echo "[Geth] Copying account keystore"
  cp /config/keystore.json $GETH_DATA_DIR/keystore/keystore.json
else
  echo "$GETH_CHAINDATA_DIR exists."
fi

exec geth \
  --datadir="$GETH_DATA_DIR" \
  --verbosity="$VERBOSITY" \
  --http \
  --http.corsdomain="*" \
  --http.vhosts="*" \
  --http.addr=0.0.0.0 \
  --http.port="$RPC_PORT" \
  --http.api="admin,web3,debug,eth,txpool,net,engine" \
  --ws \
  --ws.addr=0.0.0.0 \
  --ws.port="$WS_PORT" \
  --ws.origins="*" \
  --ws.api="admin,debug,eth,txpool,net,engine" \
  --syncmode=full \
  --networkid=$CHAIN_ID \
  --authrpc.addr="0.0.0.0" \
  --authrpc.port="8551" \
  --authrpc.vhosts="*" \
  --authrpc.jwtsecret=/config/jwt-secret.txt \
  --gcmode=archive \
  --allow-insecure-unlock \
  --password=/config/password \
  --unlock=$ADDRESS \
  --nodiscover \
  --mine \
  --miner.etherbase=$ADDRESS \
  "$@"
