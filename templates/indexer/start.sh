#docker run \
#   --platform linux/amd64 \
#   -e RPC_HTTP_URL=192.168.31.29:8545 \
#   -e SQLITE_FILENAME=/dbase/anvil.db \
#   -v sqlite-db-file:/dbase \
#   -p 8888:3001  \
#   ghcr.io/latticexyz/store-indexer:latest  \
#   pnpm start:sqlite

#!/bin/bash

# Set the environment variables
export RPC_HTTP_URL="https://rpc.garnet.qry.live/"
export STORE_ADDRESS="0x79f1ab0281c930cb7e1c8ad4bcd4c8ef1817e2d3"
export START_BLOCK="5721283"
export PORT="8089"
export POLLING_INTERVAL="1"
export RPC_WS_URL ="wss://rpc.garnet.qry.live/"

# Change to the working directory
cd /www/wwwroot/ror_indexer

# Start the indexer process
node /www/wwwroot/ror_indexer/node_modules/@latticexyz/store-indexer/dist/bin/sqlite-indexer.js
# Check the status of the process
if [ $? -eq 0 ]; then
    echo "ROR indexer started successfully."
else
    echo "Failed to start ROR indexer."
fi