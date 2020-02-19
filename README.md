# go-rest-project-template

This is a sample REST API service created using go, gin and swag.
The Makefile has a lot of useful targets to quickly run/build this project.
Goal is to create a reusable code template for golang based REST API projects.

## Contents
 - [Getting started](#getting-started)
 - [Reference](#Reference)
 - [Thanks to](#thanks-to)

## Getting started

Following instructions are tested on MacOS 10.13.6 High Sierra

1. Install Command Line Tools for Xcode, for example search for keyword "Xcode 10.1" here -> https://developer.apple.com/download/more/

2. Install golang -> https://golang.org/dl/

3. Install VSCode ->  https://code.visualstudio.com/download

4. Install docker -> https://www.docker.com/products/docker-desktop

5. Add VSCode Path, GOPATH and GOBIN variables to your bash profile. Run following in terminal.
```sh
$ cp ~/.bash_profile ~/.bash_profile.bak.$(date +%Y%m%d%H%M%S)
$ cat >>~/.bash_profile<<EOF
# Add Visual Studio Code (code) to path
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

$ Add GOLANG environment variables
export GOPATH=~/Documents/projects
export GOBIN=\${GOPATH}/bin
export PATH=\$PATH:\$GOBIN
EOF
mkdir -p ~/Documents/projects/src
```
6. Close terminal and open a new terminal so that the bew bash profile is in effect

7. Clone this project in $GOPATH/src directory
```sh
$ cd $GOPATH/src
$ git clone https://github.com/opsinfra/go-rest-project-template.git
```

8. Check if the project runs
```sh
$ cd go-rest-project-template
$ make run
```
Then open http://localhost:8080/ in web browser ( Browser will automatically get routed to swagger documentation in 5 seconds )
We can also test version endpoint using
```sh
$ curl -X GET "http://localhost:8080/api/version"
```

9. View code in VSCode
```sh
$ cd $GOPATH/src/go-rest-project-template
$ code .  # This will open . ( i.e. current directory ) in VSCode application
```

10. Other make commands
```sh
$ cd go-rest-project-template
$ make builddocker #complie go code with GOARCH=amd64 and GOOS=linux and create docker image
$ make buildgo #build go binary in directory build/out
```

## Reference

1. Sample controllers -> https://github.com/swaggo/swag/tree/master/example/celler/controller


## Thanks to

1. Project swag  -> https://github.com/swaggo/swag

2. Project gin  -> https://github.com/gin-gonic/gin

3. Project dep -> https://github.com/golang/dep

4. Project go-makefile-example -> https://github.com/azer/go-makefile-example