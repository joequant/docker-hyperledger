#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker stop vp0
docker stop vp1
docker stop ca
docker rm vp0
docker rm vp1
docker rm ca

docker run joequant/hyperledger echo

docker run --name=vp0 \
       --hostname=vp0 \
       -v $SCRIPT_DIR:/local-dev \
       -v $SCRIPT_DIR/git/fabric:/usr/lib/go-1.6/src/github.com/hyperledger/fabric \
       -p 5000:5000 \
       -p 30303:30303 \
       -e CORE_PEER_ID=vp0 \
       -e CORE_VM_ENDPOINT=http://172.17.0.1:2375 \
       -e CORE_PEER_ADDRESSAUTODETECT=true \
       joequant/hyperledger peer node start --logging-level=debug >& vp0.log &

sleep 5

docker run --name=vp1 \
       --hostname=vp1 \
       -v $SCRIPT_DIR:/local-dev \
       -v $SCRIPT_DIR/git/fabric:/usr/lib/go-1.6/src/github.com/hyperledger/fabric \
       -i \
       --link vp0:vp0 \
       -e CORE_VM_ENDPOINT=http://172.17.0.1:2375 -e \
CORE_PEER_ID=vp1 -e CORE_PEER_ADDRESSAUTODETECT=true -e \
CORE_PEER_DISCOVERY_ROOTNODE=vp0:30303 joequant/hyperledger \
       peer node start --logging-level=debug >& vp1.log &

sleep 5

docker run --name=ca \
       -p 50051:50051 \
       --hostname=ca \
       --link vp0:vp0 \
       -v $SCRIPT_DIR:/local-dev \
       -v $SCRIPT_DIR/git/fabric:/usr/lib/go-1.6/src/github.com/hyperledger/fabric \
       -i -e CORE_VM_ENDPOINT=http://172.17.0.1:2375 -e \
CORE_PEER_ID=ca -e CORE_PEER_ADDRESSAUTODETECT=true -e \
       CORE_PEER_DISCOVERY_ROOTNODE=vp0:30303 joequant/hyperledger \
       ./membersrvc --logging-level=debug >& ca.log &

sleep 5
CA=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' ca`

docker exec vp0 /bin/bash -c "echo $CA ca >> /etc/hosts"
docker exec vp1 /bin/bash -c "echo $CA ca >> /etc/hosts"
