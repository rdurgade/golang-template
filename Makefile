
# ---------------------------------------------------
# Please feel free to modify following make variables
# ---------------------------------------------------
# BASEPATH: define prefix for all API paths. Can be changed to somthing like /mysvc/api
BASEPATH = "/api" #Please do not end with /

# SWAGGERPATH: define prefix for swagger documentation. Can be changed to somthing like /mysvc/swagger
SWAGGERPATH = "/swagger" #Please do not end with /

# PORT: define the TCP port for this application to listen on
PORT = "8080"

# VERSION: define the version of this service
VERSION := "v0.0.1"

# SERVICENAME: Name for this REST API service. It will appear in version endpoint
SERVICENAME := $(shell git remote show origin  | grep Fetch | awk -F/ '{print $$NF}' | sed 's/.git//' | sort | uniq)

##
# ---------------------------------------------
# Please do not modify following make variables
# ---------------------------------------------
BUILD := $(shell git rev-parse --short HEAD)-$(shell date +%Y%m%d%H%M%S)
MAKE := $(shell which make)

LDFLAGS=-ldflags "-X=main.Version=$(VERSION) -X=main.Build=$(BUILD) -X=main.BasePath=$(BASEPATH) -X=main.Port=$(PORT) -X=main.ServiceName=$(SERVICENAME) -X=main.SwaggerPath=$(SWAGGERPATH)"

prechecks:
	@echo "[ > ] Checking if go is installed"
	@[ `go version | grep version | wc -l | awk '{print $1}'` -eq 1 ] && { echo "[ PASS ] Golang is installed"; } || { echo "[ FAILED ] Golang is not installed. Refer to installation instructions here -> https://golang.org/dl/ "; }


## make dep: Cache imported packages in vendor directory
dep:
	@echo "[ > ] Updating dependencies"
	@set -x; [ -f go.mod ] && [ -f go.sum ] ||  go mod init
	@set -x; go mod vendor

swag:
	@echo "[ > ] Checking if swag is installed"
	@echo "Gopath is $$GOPATH"
	# @set -x; ls -al $$GOPATH
	# @[ `$$GOPATH/bin/swag -v | grep  version| wc -l | awk '{print $1}'` -eq 1 ] && { echo "[ PASS ] Golang swag is installed"; } || { echo "[ FAILED ] Golang swag is not installed"; echo "[ TRY ] Attempting to install Golang swag tool"; set -x; cd $$GOPATH;go install -v  github.com/swaggo/swag/cmd/swag@v1.7.0;  set +x;sync; [ `$$GOPATH/bin/swag -v | grep  version | wc -l | awk '{print $1}'` -eq 1 ] && { echo "[ PASS ] Golang swag is installed"; }; }
	# @echo "[ > ] Updating swagger docs"
	# @set -x; ls -al $$GOPATH
	# @$$GOPATH/bin/swag init

## make run: Runs this project locally
run: swag
	@echo "[ > ] Starting application"
	@set -x; go run $(LDFLAGS) main.go

clean:
	@echo "[ > ] Cleaning build output dir"
	@sync;[ -f  build/out/${SERVICENAME}  ] && { rm -f build/out/${SERVICENAME}; echo "[ INFO ] DONE cleaning build/out"; } || { echo "[ INFO ] DONE cleaning build/out";}
	@echo "[ > ] Cleaning docker build dir"
	@sync;[ -f  build/docker/app/${SERVICENAME}  ] && { rm -f build/docker/app/${SERVICENAME}; echo "[ INFO ] DONE cleaning build/docker/app"; } || { echo "[ INFO ] DONE cleaning build/docker/app";}


## make buildgo: Builds go image
buildgo: swag
	@echo "[ > ] Building go code"
	@set -x; mkdir -p build/out; go build $(LDFLAGS) -o build/out/${SERVICENAME} main.go
	@set -x; ls -al build/out/${SERVICENAME};

buildlinuxbin: dep
	@echo "[ > ] Building go code"
	@set -x; GOOS=linux GOARCH=amd64  go build $(LDFLAGS) -o build/out/${SERVICENAME} main.go
	@set -x; ls -al build/out/${SERVICENAME};

## make builddocker: Builds docker images
builddocker: buildlinuxbin
	@echo "[ > ] Building docker image"
	@sync;set -x;cp build/out/${SERVICENAME} build/docker/app/${SERVICENAME}
	@set -x; ls -al build/docker/app/${SERVICENAME}
	@sync;set -x; cd build/docker; docker build  --build-arg BINNAME=${SERVICENAME}  -t ${SERVICENAME}:$(VERSION)-${BUILD} -t 192.168.112.245:5000/${SERVICENAME}:$(VERSION)-${BUILD} .;
	@sync;set -x; cd build/docker; docker push 192.168.112.245:5000/${SERVICENAME}:$(VERSION)-${BUILD};
	@sync;set -x; cd build/docker; sed  "s/replace_this/$(VERSION)-${BUILD}/g" Kustomization.template > Kustomization;cat Kustomization
	@$(MAKE) clean
	@sync;set -x; echo $${API_TOKEN_GITHUB}
:
.PHONY: help
all: help
help: Makefile
	@echo
	@echo " Choose a command run in "$(SERVICENAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo
