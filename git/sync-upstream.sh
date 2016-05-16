#!/bin/bash
for i in fabric hyperledger-fabric-js marbles chaincode-investigator marbles-chaincode cp-web cp-chaincode-v2 ; do
    pushd $i
    git fetch upstream
    git checkout upstream
    git rebase upstream/master
    git checkout master
    git rebase upstream/master
    popd
done

    
