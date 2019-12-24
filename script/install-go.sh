#!/bin/bash
set -eux

GOLANG_VERSION=1.13.5
goRelArch="linux-amd64"
goRelSha256="512103d7ad296467814a6e3f635631bd35574cab3369a97a323c9a585ccaa569"
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
    github.com/stamblerre/gocode \
    github.com/rogpeppe/godef \
    github.com/zmb3/gogetdoc \
    golang.org/x/tools/cmd/goimports \
    golang.org/x/lint/golint \
    golang.org/x/tools/gopls \
    github.com/golangci/golangci-lint/cmd/golangci-lint \
    github.com/fatih/gomodifytags \
    golang.org/x/tools/cmd/gorename \
    github.com/jstemmer/gotags \
    golang.org/x/tools/cmd/guru \
    github.com/josharian/impl \
    honnef.co/go/tools/cmd/keyify \
    github.com/fatih/motion \
    github.com/koron/iferr

mv $GOBIN/gocode $GOBIN/gocode-gomod
go get github.com/mdempsky/gocode
go clean -cache
rm -rf $GOPATH
