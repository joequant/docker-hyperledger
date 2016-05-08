#!/bin/bash

pushd fabric
git fetch upstream
git checkout master
git rebase upstream/master
git checkout devel
git rebase upstream/master
git checkout devel
popd

pushd hyperledger-fabric-js
git fetch upstream
git checkout master
git rebase upstream/master
popd

for i in marbles chaincode-investigator marbles-chaincode cp-web cp-chaincode-v2 ; do
    pushd $i
    git fetch upstream
    git checkout master
    git rebase upstream/master
    popd
done

    
