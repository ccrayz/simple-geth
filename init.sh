export GETH_DATADIR=data/geth
mkdir -p $GETH_DATADIR
openssl rand -hex 32 | tr -d "\n" > "$GETH_DATADIR/jwt.hex"