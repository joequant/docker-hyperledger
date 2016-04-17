#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker stop vp0
docker stop vp1
docker rm vp0
docker rm vp1

docker run joequant/hyperledger echo

docker run --name=vp0 \
       --restart=unless-stopped \
       -v $SCRIPT_DIR:/local-dev \
       -p 5000:5000 \
       -p 30303:30303 \
       -e CORE_PEER_ID=vp0 \
       -e CORE_VM_ENDPOINT=http://172.17.0.1:4243 \
       -e CORE_PEER_ADDRESSAUTODETECT=true \
       joequant/hyperledger fabric peer >& vp0.log &

docker run --name=vp1 \
       --restart=unless-stopped \
       -v $SCRIPT_DIR:/local-dev \
       -i -e CORE_VM_ENDPOINT=http://172.17.0.1:4243 -e \
CORE_PEER_ID=vp1 -e CORE_PEER_ADDRESSAUTODETECT=true -e \
CORE_PEER_DISCOVERY_ROOTNODE=172.17.0.2:30303 joequant/hyperledger fabric \
peer --logging-level=debug >& vp1.log &
