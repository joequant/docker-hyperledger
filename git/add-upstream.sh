#!/bin/bash

git submodule add https://github.com/joequant/fabric.git
pushd fabric
git remote add upstream https://github.com/hyperledger/fabric.git
popd

git submodule add https://github.com/joequant/hyperledger-fabric-js.git
pushd hyperledger-fabric-js
git remote add upstream https://github.com/IBM-Blockchain/ibm-blockchain-js.git
popd

for i in marbles chaincode-investigator marbles-chaincode cp-web cp-chaincode-v2 ; do
git submodule add https://github.com/joequant/$i.git
pushd $i
git remote add upstream https://github.com/IBM-Blockchain/$i.git
popd
done

