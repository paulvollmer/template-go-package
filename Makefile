CURRENT_DIR := $(shell pwd)
TIMESTAMP := $(shell date "+%s")
VERSION := 0.0.0
GIT_HASH := $(shell git rev-parse --short HEAD)
LDFLAGS = -ldflags "-X main.version=${VERSION} -X main.commit=${GIT_HASH}"
BINARY = template
BUILD_DIR = cmd/template
GOARCH = amd64

all: fmt lint test build

install:
	go get -v
	go get -u github.com/golangci/golangci-lint/cmd/golangci-lint

fmt:
	@go fmt ./...

lint:
	@golangci-lint run -E misspell ./...

.PHONY: fmt lint

test:
	@go test -count=1 ./...

test-cov:
	@go test -count=1 -coverprofile=coverage.out ./...
	@go tool cover -html=coverage.out

.PHONY: test test-cov

build:
	@cd ${BUILD_DIR} && go build ${LDFLAGS} -o ${BINARY}

build-linux:
	@cd ${BUILD_DIR} && GOOS=linux GOARCH=${GOARCH} go build ${LDFLAGS} -o ${BINARY}-linux-${GOARCH}

build-darwin:
	@cd ${BUILD_DIR} && GOOS=darwin GOARCH=${GOARCH} go build ${LDFLAGS} -o ${BINARY}-darwin-${GOARCH}

build-windows:
	@cd ${BUILD_DIR} && GOOS=windows GOARCH=${GOARCH} go build ${LDFLAGS} -o ${BINARY}-windows-${GOARCH}.exe

.PHONY: build build-linux build-darwin build-windows

clean:
	@rm -f ${BUILD_DIR}/${BINARY}*
	@rm -f coverage.out

.PHONY: clean
