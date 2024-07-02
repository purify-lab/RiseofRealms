Depoly on Garnet Holesky
JSON RPC HOST: https://rpc.garnet.qry.live/
WS RPC HOST: wss://rpc.garnet.qry.live/ 
FAUCET HOST:  

CHAIN CODE:17069
BLOCK SCAN:https://garnet.blockscout.com/

export PRIVATE_KEY=0xfb61ae9ea723f1bff3f7bd183ffbaa730127d9a7ba4fab24340b64fb1904ee5f
forge script PostDeploy --sig "run(address)"  "0x8dcad0927817149609866124167337094b12beef" --broadcast --rpc-url https://rpc.garnet.qry.live/ -vvv --priority-gas-price 100