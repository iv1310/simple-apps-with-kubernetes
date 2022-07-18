#!/bin/sh 

set -eux

export FAILED=false
export CGO_ENABLED=0

apk add --no-cache git
go mod download
go test ./...
go build -installsuffix 'static' -o ./app ./cmd/app/main.go
