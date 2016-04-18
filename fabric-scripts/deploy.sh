#!/bin/bash
export CORE_PEER_ADDRESS=172.17.0.2:30303

fabric chaincode deploy -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02 -c '{"Function":"init", "Args": ["a","100", "b", "200"]}'

if [ ! -d /opt/gopath/src/github.com/joequant/hyperledger ] ; then
    mkdir -p /opt/gopath/src/github.com/joequant
    pushd /opt/gopath/src/github.com/joequant > /dev/null
    git clone http://github.com/joequant/hyperledger.git
    popd > /dev/null
fi

pushd /opt/gopath/src/github.com/joequant/hyperledger
git pull
popd

fabric chaincode deploy -p github.com/joequant/hyperledger/examples/chaincode/go/map -c '{"Function":"init", "Args": []}'
