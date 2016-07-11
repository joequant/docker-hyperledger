#!/bin/bash
export CORE_PEER_ADDRESS=vp0:30303

peer chaincode deploy $FABRIC_ARGS -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02 -c '{"Function":"init", "Args": ["a","100", "b", "200"]}'

#peer chaincode deploy -p github.com/joequant/hyperledger/examples/chaincode/go/map -c '{"Function":"init", "Args": []}'
