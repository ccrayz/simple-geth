#!/bin/bash

mkdir -p account
echo "password" > ./account/password

docker run -v ./account:/account ethereum/client-go:latest --datadir /account account new --password /account/password
chown -R ubuntu:ubuntu ./account/keystore

keystore_path=(./account/keystore/UTC*)
echo "${keystore_path[-1]}"
cp "${keystore_path[-1]}" ./config/keystore.json

openssl rand -hex 32 > ./config/jwt-secret.txt
