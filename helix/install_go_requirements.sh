#!/bin/bash

go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.64.6
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/gopls@latest
