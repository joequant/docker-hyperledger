Docker-Hyperledger
===
Base Docker images for [Hyperledger](https://www.hyperledger.org).

Quick Start
===
Make sure that docker runs with options

--api-cors-header="*" -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock
  
install-docker.sh does this on Redhat/Mageia systems

If you want to build the image locally rather than download the
dockerhub image

./fabric-setup.sh

Otherwise

./startnet.sh
./fabric-run.sh fabric-scripts/deploy.sh
./fabric-run.sh fabric-scripts/run-test.sh

# Supported tags and respective Dockerfile links

For more information about this image and its history, please see the relevant manifest file in the [`joequant/hyperledger` GitHub repo](https://github.com/joequant/hyperledger).

# How to use this image?
The docker image is auto built at [https://registry.hub.docker.com/u/yeasy/hyperledger/](https://registry.hub.docker.com/u/yeasy/hyperledger/).

## install hyperledger
Install hyperledger and build the fabric as peer 

# Supported Docker versions

This image is officially supported on Docker version 1.7.0.

Support for older versions (down to 1.0) is provided on a best-effort basis.

# Known Issues
* N/A.

# User Feedback
## Documentation
Be sure to familiarize yourself with the [repository's `README.md`](https://github.com/joequant/hyperledger/blob/master/README.md) file before attempting a pull request.

## Issues
If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/joequant/hyperledger/issues).

You can also reach many of the official image maintainers via the email.

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/joequant/hyperledger/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
