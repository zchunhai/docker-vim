#!/bin/bash
set -eux

GOLANG_VERSION=1.14
goRelArch="linux-amd64"
url="https://golang.org/dl/go${GOLANG_VERSION}.${goRelArch}.tar.gz"

wget -O go.tgz "$url"
tar -C /usr/local -xzf go.tgz && rm go.tgz
export PATH="/usr/local/go/bin:$PATH"
go version

export GOPATH=/tmp/go_work
export GOBIN=/usr/local/go/bin
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $GOBIN v1.24.0

go get -u -buildmode=exe -ldflags '-s -w' \
    github.com/klauspost/asmfmt/cmd/asmfmt \
    github.com/go-delve/delve/cmd/dlv \
    github.com/kisielk/errcheck \
    github.com/davidrjenni/reftools/cmd/fillstruct \
    github.com/rogpeppe/godef \
    github.com/zmb3/gogetdoc \
    golang.org/x/tools/cmd/goimports \
    golang.org/x/lint/golint \
    golang.org/x/tools/gopls \
    github.com/fatih/gomodifytags \
    golang.org/x/tools/cmd/gorename \
    github.com/jstemmer/gotags \
    golang.org/x/tools/cmd/guru \
    github.com/josharian/impl \
    honnef.co/go/tools/cmd/keyify \
    github.com/fatih/motion \
    github.com/koron/iferr

go clean -cache
rm -rf $GOPATH
