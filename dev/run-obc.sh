#!/bin/bash
cd /hyperledger
export CORE_PEER_ADDRESS=172.17.0.2:30303
NAME=`./peer chaincode deploy -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02 -c '{"Function":"init", "Args": ["a","100", "b", "200"]}'`

echo $NAME
./peer chaincode invoke -n $NAME -c '{"Function": "invoke", "Args": ["a", "b", "10"]}'
./peer chaincode query -l golang -n $NAME -c '{"Function": "query", "Args": ["a"]}'
