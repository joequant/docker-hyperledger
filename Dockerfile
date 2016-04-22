# Dockerfile for Hyperledger base image, with everything to go!
# Data is stored under /var/hyperledger/db and /var/hyperledger/production
# Under $GOPATH/bin, there are two config files: core.yaml and config.yaml.

FROM library/ubuntu:trusty
MAINTAINER Joseph Wang <joequant@gmail.com>

# install go
ENV GOPATH /opt/gopath
ENV GOROOT /opt/go
ENV PATH /opt/gopath/bin:/opt/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    &&  apt-get install -y curl tar \
    && rm -rf /var/cache/apt /usr/share/doc /usr/share/man \
    && cd /opt \
    && curl -s https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz | tar -xvzf - \
    && rm -rf go/doc go/blog go/test go/blog go/api \
    && ln -s /opt/go $GOPATH \
    && curl https://raw.githubusercontent.com/joequant/hyperledger/master/config/gopath.sh > /etc/profile.d/gopath.sh \
    && chmod 0755 /etc/profile.d/gopath.sh \
    && mkdir -p /var/hyperledger/db \
    && mkdir -p /var/hyperledger/production

RUN apt-get install -y protobuf-compiler libsnappy-dev zlib1g-dev libbz2-dev \
        unzip \
        build-essential libtool git-core \
	--no-install-recommends --no-install-suggests \
	&& strip /usr/bin/* /usr/sbin/* /opt/go/bin/* || true \
        && rm -rf /var/cache/apt /usr/share/doc /usr/share/man \
	&& cd /tmp \
        && git clone --single-branch -b v4.1 --depth 1 https://github.com/facebook/rocksdb.git \
        && cd rocksdb \
        && PORTABLE=1 make shared_lib \
        && INSTALL_PATH=/usr/local make install-shared \
        && ldconfig \
        && cd .. \
        && rm -rf rocksdb 

# install hyperledger
RUN mkdir -p $GOPATH/src/github.com/hyperledger \
        && cd $GOPATH/src/github.com/hyperledger \
        && git clone --single-branch -b master --depth 1 https://github.com/hyperledger/fabric.git \
        && cd $GOPATH/src/github.com/hyperledger/fabric/peer \
        && CGO_CFLAGS=" " CGO_LDFLAGS="-lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy" go install \
	&& cp core.yaml $GOPATH/bin/ \
        && go clean \
        && cd $GOPATH/src/github.com/hyperledger/fabric/membersrvc \
        && CGO_CFLAGS=" " CGO_LDFLAGS="-lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy" go install \
	&& cp membersrvc.yaml $GOPATH/bin/ \
        && go clean \
	&& cp $GOPATH/src/github.com/hyperledger/fabric/consensus/noops/config.yaml $GOPATH/bin

WORKDIR "$GOPATH/bin
