#!/bin/bash
sudo ./install-docker.sh
docker build -t joequant/hyperledger .
docker tag joequant/hyperledger hyperledger
docker tag joequant/hyperledger openblockchain/baseimage
