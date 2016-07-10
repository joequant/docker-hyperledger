#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker stop vp0
docker stop vp1
docker stop ca
docker rm vp0
docker rm vp1
docker rm ca

docker run joequant/hyperledger echo
docker run --name=ca \
       -p 50051:50051 \
       --hostname=ca \
       -v $SCRIPT_DIR:/local-dev \
       -v $SCRIPT_DIR/git/fabric:/usr/lib/go-1.6/src/github.com/hyperledger/fabric \
       -i \
       joequant/hyperledger \
       ./membersrvc --logging-level=debug >& ca.log &

sleep 5

docker run --name=vp0 \
       --hostname=vp0 \
       --link ca:ca \
       -v $SCRIPT_DIR:/local-dev \
       -v $SCRIPT_DIR/git/fabric:/usr/lib/go-1.6/src/github.com/hyperledger/fabric \
       -p 5000:5000 \
       -p 30303:30303 \
       -e CORE_PEER_ID=vp0 \
       -e CORE_VM_ENDPOINT=http://172.17.0.1:2375 \
       -e CORE_PEER_ADDRESSAUTODETECT=true \
       -e CORE_SECURITY_ENABLED=true \
       -e CORE_SECURITY_PRIVACY=true \
       -e CORE_PEER_PKI_ECA_PADDR=ca:50051 \
       -e CORE_PEER_PKI_TCA_PADDR=ca:50051 \
       -e CORE_PEER_PKI_TLSCA_PADDR=ca:50051 \
       -e CORE_SECURITY_ENROLLID=vp0 \
       -e CORE_SECURITY_ENROLLSECRET=vp0_secret \
       joequant/hyperledger peer node start --logging-level=debug >& vp0.log &

sleep 5

docker run --name=vp1 \
       --hostname=vp1 \
       -v $SCRIPT_DIR:/local-dev \
       -v $SCRIPT_DIR/git/fabric:/usr/lib/go-1.6/src/github.com/hyperledger/fabric \
       -i \
       --link vp0:vp0 \
       --link ca:ca \
       -e CORE_VM_ENDPOINT=http://172.17.0.1:2375 -e \
       CORE_PEER_ID=vp1 -e CORE_PEER_ADDRESSAUTODETECT=true \
       -e CORE_PEER_DISCOVERY_ROOTNODE=vp0:30303 \
       -e CORE_SECURITY_ENABLED=true \
       -e CORE_SECURITY_PRIVACY=true \
       -e CORE_PEER_PKI_ECA_PADDR=ca:50051 \
       -e CORE_PEER_PKI_TCA_PADDR=ca:50051 \
       -e CORE_PEER_PKI_TLSCA_PADDR=ca:50051 \
       -e CORE_SECURITY_ENROLLID=vp1 \
       -e CORE_SECURITY_ENROLLSECRET=vp1_secret \
       joequant/hyperledger \
       peer node start --logging-level=debug >& vp1.log &



