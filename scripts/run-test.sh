#!/bin/bash
export CORE_PEER_ADDRESS=vp0:30303

NAME=`peer chaincode deploy -u jim -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02 -c '{"Function":"init", "Args": ["a","100", "b", "200"]}'`

peer chaincode invoke -n $NAME -u jim -c '{"Function": "invoke", "Args": ["a", "b", "10"]}'
peer chaincode query -l golang -n $NAME -u jim -c '{"Function": "query", "Args": ["a"]}' 

