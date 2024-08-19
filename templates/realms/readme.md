Depoly on Garnet Holesky
JSON RPC HOST: https://rpc.garnet.qry.live/
WS RPC HOST: wss://rpc.garnet.qry.live/ 
FAUCET HOST:  
EXPLORE:https://explorer.garnetchain.com
Indexer:http://44.214.29.84:8089/


CHAIN CODE:17069
BLOCK SCAN:https://garnet.blockscout.com/

export PATH="/usr/local/opt/node@18/bin:$PATH"
pnpm run build

export PRIVATE_KEY=0xfb61ae9ea723f1bff3f7bd183ffbaa730127d9a7ba4fab24340b64fb1904ee5f
cd packages/contracts      
pnpm run deploy:redstone_holesky



forge script PostDeploy --sig "run(address)"  "0xdd8ebc2cbcde94d7c12fe137d0cb47ec560ea587" --broadcast --rpc-url https://rpc.garnet.qry.live/ -vvv --priority-gas-price 100