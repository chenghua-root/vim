#!/bin/bash

set -e	# or use "set -o errexit" to quit on error.
set -x  # or use "set -o xtrace" to print the statement before you execute it.

go get github.com/nsf/gocode
go get github.com/zmb3/gogetdoc

go get github.com/klauspost/asmfmt/cmd/asmfmt
go get github.com/go-delve/delve/cmd/dlv
go get github.com/kisielk/errcheck
go get github.com/davidrjenni/reftools/cmd/fillstruct
go get github.com/rogpeppe/godef
go get golang.org/x/tools/cmd/goimports
go get golang.org/x/lint/golint
go get github.com/mgechev/revive
go get golang.org/x/tools/gopls
go get github.com/golangci/golangci-lint/cmd/golangci-lint
go get honnef.co/go/tools/cmd/staticcheck
go get github.com/fatih/gomodifytags
go get golang.org/x/tools/cmd/gorename
go get github.com/jstemmer/gotags
go get golang.org/x/tools/cmd/guru
go get github.com/josharian/impl
go get honnef.co/go/tools/cmd/keyify
go get github.com/fatih/motion
go get github.com/koron/iferr
