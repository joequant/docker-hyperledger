#!/bin/bash

pushd fabric
git checkout master
git push
git checkout devel
git push
git checkout devel
popd

pushd hyperledger-fabric-js
git checkout master
git push
popd

for i in marbles chaincode-investigator marbles-chaincode cp-web cp-chaincode-v2 ; do
    pushd $i
    git checkout master
    git push
    popd
done
