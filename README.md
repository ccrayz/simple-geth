# Simple Geth

This is a project created to make it easier to run geth with docker compose.
Currently, I created it for personal use to run an Ethereum node.

So for now, I'm trying to keep it simple and provision an environment that I can run and monitor.
In the future, it would be nice to be able to use it as an example for provisioning various networks.

## Getting Started

First, run ./init.sh to create the files and directories needed to run the node.

> Ensure that all data is managed in the ./data directory.

```
./init.sh
```

## Run Node

Run the docker compose command to run the node and monitoring environment.

```
docker compose up -d
```

## Remove Node

Execute the docker compose command to exit the container.

```
docker compose down -v

# Execute the command below to delete all used data.
./remove.sh
```
