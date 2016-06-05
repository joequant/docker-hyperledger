#!/bin/bash

for i in fabric hyperledger-fabric-js marbles chaincode-investigator cp-web cp-chaincode-v2 ; do
    pushd $i
    git checkout master
    git push
    popd
done
