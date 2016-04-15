#!/bin/bash

docker build -t hyperledger .
docker tag hyperledger openblockchain/baseimage
