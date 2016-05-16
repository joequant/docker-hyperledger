#!/bin/bash
set -e
export FABRIC_REPO=joequant
export PATH=/opt/gopath/bin:/opt/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#install go and protobuf
rm -f /var/lib/apt/lists/*Sources* /var/lib/apt/lists/*universe*
sed -i /universe/d /etc/apt/sources.list
apt-get purge -y eject whiptail
apt-get install -y curl binutils golang-1.6-go apt-utils
rm -rf /var/cache/apt /usr/share/doc /usr/share/man
rm -rf /usr/share/go-1.6/test
ln -s $GOROOT /opt/go
ln -s $GOROOT /opt/gopath
mkdir -p /var/hyperledger/db
mkdir -p /var/hyperledger/production
strip --strip-unneeded /usr/bin/* /usr/sbin/* || true 
strip --strip-unneeded  $GOROOT/bin/* $GOROOT/pkg/tool/*/* || true
apt-get install -y protobuf-compiler libsnappy-dev zlib1g-dev libbz2-dev \
        unzip build-essential git-core libstdc++-5-dev \
	--no-install-recommends --no-install-suggests
strip --strip-unneeded /usr/bin/* /usr/sbin/* || true 
strip --strip-unneeded /usr/lib/* /usr/local/lib/* || true
rm -rf /var/cache/apt /usr/share/doc /usr/share/man

#install rocksdb
cd /tmp
git clone --single-branch -b v4.1 --depth 1 https://github.com/facebook/rocksdb.git
cd rocksdb
PORTABLE=1 make shared_lib
INSTALL_PATH=/usr/local make install-shared
ldconfig
cd ..
rm -rf rocksdb
apt-get purge -y make patch xz-utils g++ libdpkg-perl \
	    libtimedate-perl sgml-base xml-core xdg-user-dirs manpages \
	    krb5-locales libglib2.0-0 libxtables11 shared-mime-info \
	    ifupdown rename
apt-get purge -y --allow-remove-essential sed e2fsprogs
apt-get autoremove -y
strip --strip-unneeded /usr/local/lib/* || true 

# install hyperledger
mkdir -p $GOPATH/src/github.com/hyperledger
cd $GOPATH/src/github.com/hyperledger
git clone --single-branch --depth 1 https://github.com/$FABRIC_REPO/fabric.git
cd $GOPATH/src/github.com/hyperledger/fabric/peer
CGO_CFLAGS=" " CGO_LDFLAGS="-lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy" go install
cp core.yaml $GOPATH/bin/
go clean

cd $GOPATH/src/github.com/hyperledger/fabric/membersrvc
CGO_CFLAGS=" " CGO_LDFLAGS="-lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy" go install
cp membersrvc.yaml $GOPATH/bin/
go clean

strip $GOPATH/bin/* || true
cp $GOPATH/src/github.com/hyperledger/fabric/consensus/noops/config.yaml $GOPATH/bin


