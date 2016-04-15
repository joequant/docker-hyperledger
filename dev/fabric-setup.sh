#!/bin/bash
sudo ./install-docker.sh
docker build -t hyperledger .
docker tag hyperledger openblockchain/baseimage
