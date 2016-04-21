export GOPATH=/opt/gopath
export GOROOT=/opt/go
export PATH="$GOROOT/bin:$GOPATH/bin:\$PATH"
export CGO_CFLAGS=" "
export CGO_LDFLAGS="-lrocksdb -lstdc++ -lm -lz -lbz2 -lsnappy"
