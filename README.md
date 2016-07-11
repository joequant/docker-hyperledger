Docker-Hyperledger
===
Base Docker images for [Hyperledger](https://www.hyperledger.org).

Quick Start
===
Make sure that docker runs with options

--api-cors-header="*" -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
  
install-docker.sh does this on Redhat/Mageia systems

If you want to build the image locally rather than download the
dockerhub image

./fabric-setup.sh

Otherwise

./startnet.sh or ./startnet-secure.sh

Run test items

./fabric-run.sh scripts/deploy.sh
./fabric-run.sh scripts/run-test.sh
./fabric-rest.js json/method.chaincode.json json/example02-deploy.json
./fabric-rest.js json/method.chaincode.json json/example02-invoke.json
./fabric-rest.js json/method.chaincode.json json/example02-query.json

# Supported tags and respective Dockerfile links

For more information about this image and its history, please see the relevant manifest file in the [`joequant/hyperledger` GitHub repo](https://github.com/joequant/hyperledger).

# How to use this image?
The docker image is auto built at [https://registry.hub.docker.com/u/yeasy/hyperledger/](https://registry.hub.docker.com/u/yeasy/hyperledger/).

## install hyperledger
Install hyperledger and build the fabric as peer 

Notes
=====

fabric-rest.js json/chain.method

