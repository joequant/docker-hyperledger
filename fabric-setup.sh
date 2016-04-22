#!/bin/bash
sudo ./install-docker.sh
docker build --no-cache=true -t joequant/hyperledger .
docker tag -f joequant/hyperledger hyperledger
docker tag -f joequant/hyperledger openblockchain/baseimage
