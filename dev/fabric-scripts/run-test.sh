#!/bin/bash
export CORE_PEER_ADDRESS=172.17.0.2:30303

NAME=`fabric chaincode deploy -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02 -c '{"Function":"init", "Args": ["a","100", "b", "200"]}'`

fabric chaincode invoke -n $NAME -c '{"Function": "invoke", "Args": ["a", "b", "10"]}'
fabric chaincode query -l golang -n $NAME -c '{"Function": "query", "Args": ["a"]}'
