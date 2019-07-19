#!/bin/bash
set -eux

GOLANG_VERSION=1.12.6
goRelArch="linux-amd64"
goRelSha256="dbcf71a3c1ea53b8d54ef1b48c85a39a6c9a935d01fc8291ff2b92028e59913c"
url="https://golang.org/dl/go${GOLANG_VERSION}.${goRelArch}.tar.gz"

wget -O go.tgz "$url" && echo "${goRelSha256} *go.tgz" | sha256sum -c -
tar -C /usr/local -xzf go.tgz && rm go.tgz
export PATH="/usr/local/go/bin:$PATH"
go version

export GOPATH=/tmp/go_work
export GOBIN=/usr/local/go/bin

go get -u -buildmode=exe -ldflags '-s -w' \
    github.com/klauspost/asmfmt/cmd/asmfmt \
    github.com/go-delve/delve/cmd/dlv \
    github.com/kisielk/errcheck \
    github.com/davidrjenni/reftools/cmd/fillstruct \
    github.com/rogpeppe/godef \
    github.com/zmb3/gogetdoc \
    golang.org/x/tools/cmd/goimports \
    golang.org/x/lint/golint \
    golang.org/x/tools/cmd/gopls \
    github.com/alecthomas/gometalinter \
    github.com/golangci/golangci-lint/cmd/golangci-lint \
    github.com/fatih/gomodifytags \
    golang.org/x/tools/cmd/gorename \
    github.com/jstemmer/gotags \
    golang.org/x/tools/cmd/guru \
    github.com/josharian/impl \
    honnef.co/go/tools/cmd/keyify \
    github.com/fatih/motion \
    github.com/koron/iferr \
    github.com/stamblerre/gocode

mv $GOBIN/gocode $GOBIN/gocode-gomod
go get github.com/mdempsky/gocode
go clean -cache
rm -rf $GOPATH
