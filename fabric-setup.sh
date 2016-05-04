#!/bin/bash
sudo ./install-docker.sh
docker build $* -t joequant/hyperledger .
docker tag -f joequant/hyperledger hyperledger
docker tag -f joequant/hyperledger openblockchain/baseimage
