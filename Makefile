BUILD_PATH ?= .

ifdef COMSPEC
EXAMPLE := example\\example.exe
else
EXAMPLE := example/example
endif

.PHONY: all vet build test clean

all: deps vet build test

deps:

	go get "github.com/K-Phoen/negotiation"
	go get "github.com/dimfeld/httptreemux"
	go get "github.com/gorilla/schema"
	go get "github.com/prometheus/client_golang/prometheus"
	go get "github.com/rs/cors"
	go get "github.com/sirupsen/logrus"
	go get "gopkg.in/SpirentOrion/trace.v2"
	go get "gopkg.in/yaml.v2"
	go get "github.com/SpirentOrion/luddite.v2"

vet:
	cd $(BUILD_PATH) && go vet -all -composites=false -shadow=true ./...

build:
	cd $(BUILD_PATH) && go build .
	cd $(BUILD_PATH) && go build -o $(EXAMPLE) ./example/...

test:
	cd $(BUILD_PATH) && go test -race

clean:
	cd $(BUILD_PATH) && go clean
	rm -f $(EXAMPLE)
