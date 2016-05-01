# Dockerfile for Hyperledger base image, with everything to go!
# Data is stored under /var/hyperledger/db and /var/hyperledger/production
# Under $GOPATH/bin, there are two config files: core.yaml and config.yaml.

FROM library/ubuntu:xenial
MAINTAINER Joseph Wang <joequant@gmail.com>

# install go
ENV GOPATH /usr/lib/go-1.6
ENV GOROOT /usr/lib/go-1.6
ENV PATH /opt/gopath/bin:/opt/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV FABRIC_REPO joequant
ENV FABRIC_BRANCH devel
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get purge -y eject whiptail \
    &&  apt-get install -y curl tar binutils golang-1.6-go apt-utils \
    && rm -rf /var/cache/apt /usr/share/doc /usr/share/man \
    && ln -s $GOROOT /opt/go \
    && ln -s $GOROOT /opt/gopath \
    && mkdir -p /var/hyperledger/db \
    && mkdir -p /var/hyperledger/production \
    && strip --strip-unneeded /usr/bin/* /usr/sbin/* || true \
    && strip --strip-unneeded  $GOROOT/bin/* $GOROOT/pkg/tool/*/* || true

RUN apt-get install -y protobuf-compiler libsnappy-dev zlib1g-dev libbz2-dev \
        unzip \
        build-essential git-core \
	--no-install-recommends --no-install-suggests \
	&& strip --strip-unneeded /usr/bin/* /usr/sbin/* || true \
	&& strip --strip-unneeded /usr/lib/* /usr/local/lib/* || true \	
        && rm -rf /var/cache/apt /usr/share/doc /usr/share/man \
	&& cd /tmp \
        && git clone --single-branch -b v4.1 --depth 1 https://github.com/facebook/rocksdb.git \
        && cd rocksdb \
        && PORTABLE=1 make shared_lib \
        && INSTALL_PATH=/usr/local make install-shared \
        && ldconfig \
        && cd .. \
        && rm -rf rocksdb  \
	&& apt-get purge -y make patch xz-utils g++ libdpkg-perl libtimedate-perl \
	&& strip --strip-unneeded /usr/local/lib/* || true 

# install hyperledger
RUN mkdir -p $GOPATH/src/github.com/hyperledger \
        && cd $GOPATH/src/github.com/hyperledger \
        && git clone --single-branch -b $FABRIC_BRANCH --depth 1 https://github.com/$FABRIC_REPO/fabric.git \
        && cd $GOPATH/src/github.com/hyperledger/fabric/peer \
        && CGO_CFLAGS=" " CGO_LDFLAGS="-lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy" go install \
	&& cp core.yaml $GOPATH/bin/ \
        && go clean \
        && cd $GOPATH/src/github.com/hyperledger/fabric/membersrvc \
        && CGO_CFLAGS=" " CGO_LDFLAGS="-lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy" go install \
	&& cp membersrvc.yaml $GOPATH/bin/ \
        && go clean \
	&& strip $GOPATH/bin/* || true \
	&& cp $GOPATH/src/github.com/hyperledger/fabric/consensus/noops/config.yaml $GOPATH/bin

WORKDIR "$GOPATH/bin
