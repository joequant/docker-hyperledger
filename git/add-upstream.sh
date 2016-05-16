#!/bin/bash

git submodule add https://github.com/joequant/fabric.git
pushd fabric
git remote add upstream https://github.com/hyperledger/fabric.git
git branch upstream
popd

git submodule add https://github.com/joequant/hyperledger-fabric-js.git
pushd hyperledger-fabric-js
git remote add upstream https://github.com/IBM-Blockchain/ibm-blockchain-js.git
git branch upstream
popd

for i in marbles chaincode-investigator marbles-chaincode cp-web cp-chaincode-v2 ; do
git submodule add https://github.com/joequant/$i.git
pushd $i
git remote remove upstream
git remote add upstream https://github.com/IBM-Blockchain/$i.git
git branch upstream
popd
done

