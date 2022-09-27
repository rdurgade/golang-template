# Golang based REST API Project Template

[![Gitlab CI Build Status](https://gitlab.com/opsinfra/${{values.component_id}}/badges/master/pipeline.svg)](https://gitlab.com/opsinfra/${{values.component_id}}/-/commits/master)

This is a simple REST API service created using go, gin and swag.
The Makefile has many useful targets to quickly run/build this project.
Goal is to create a reusable code template for golang based REST API projects.

## Contents
 - [Getting started](#getting-started)
 - [How to use this template for a new project](#How-to-use-this-template-for-a-new-project)
 - [Reference](#Reference)
 - [Thanks to](#thanks-to)

## Getting started

Following instructions are tested on **MacOS** 10.13.6 High Sierra

1. Install Xcode *or* **Command Line Tools for Xcode**, for example search for keyword "Xcode 10.1" here -> https://developer.apple.com/download/more/

2. Install golang -> https://golang.org/dl/

3. Install VSCode ->  https://code.visualstudio.com/download

4. Install docker -> https://www.docker.com/products/docker-desktop

5. Add VSCode Path, GOPATH and GOBIN variables to your bash profile. Run following in terminal.
```sh
$ cp ~/.bash_profile ~/.bash_profile.bak.$(date +%Y%m%d%H%M%S)
$ cat >>~/.bash_profile<<EOF
# Add Visual Studio Code (code) to path
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Add GOLANG environment variables
export GOPATH=~/Documents/projects
export GOBIN=\${GOPATH}/bin
export PATH=\$PATH:\$GOBIN
EOF
mkdir -p ~/Documents/projects/src
```
6. Close terminal and open a new terminal so that the new bash profile is in effect

7. Clone this project in $GOPATH/src directory
```sh
$ cd $GOPATH/src
$ git clone https://github.com/opsinfra/${{values.component_id}}.git
```

8. Run this project
```sh
$ cd ${{values.component_id}}
$ make run
```
Then open http://localhost:8080/ in web browser ( Browser will automatically get routed to swagger documentation in 5 seconds )
We can also test version endpoint using following curl command
```sh
$ curl -X GET "http://localhost:8080/api/version"
```

9. View code in VSCode
```sh
$ cd $GOPATH/src/${{values.component_id}}
$ code .  # This will open . ( i.e. current directory ) in VSCode application
```

10. Other make commands
```sh
$ cd ${{values.component_id}}
$ make builddocker #complie go code with GOARCH=amd64 and GOOS=linux and create docker image
$ make buildgo #build go binary in directory build/out
$ make help #shows help
```

## How to use this template for a new project
- **Prerequisite**: Complete setup as documented in section [Getting started](#getting-started)

1. Create a new project in github
```sh
Example:
    We would go to https://github.com/opsinfra?tab=repositories
    Click on green button labeled "New"
    Fill in "Repository name" with name for new service such as  "mysvc"
    Click on green button labeled "Create repository"
```

2. Mirror this template into the new git repository
```sh
Example:
    $ cd $GOPATH/src/${{values.component_id}}
    $ git push --mirror https://github.com/opsinfra/mysvc
```

3. Clone the new git repository
```sh
Example:
    $ cd $GOPATH/src
    $ git clone https://github.com/opsinfra/mysvc
```

4. Replace name ${{values.component_id}} in main.go with new project name
```sh
Example:
    $ cd $GOPATH/src/mysvc
    $ sed -i '' "s/${{values.component_id}}/${PWD##*/}/g" main.go  # On Linux, this line would be sed -i main.go "s/${{values.component_id}}/${PWD##*/}/g"
```

5. Now the application should start
```sh
Example:
    $ cd $GOPATH/src/mysvc
    $ make run
```

6. **Important note**
- Most likely, as we build project, more go packages will be imported. Whenever that happens, we need to run **make dep** before *make run* so that those imported packages can be cached in vendor folder.  
 



## Reference

1. Sample controllers -> https://github.com/swaggo/swag/tree/master/example/celler/controller


## Thanks to

1. Project swag  -> https://github.com/swaggo/swag

2. Project gin  -> https://github.com/gin-gonic/gin

3. Project dep -> https://github.com/golang/dep

4. Project go-makefile-example -> https://github.com/azer/go-makefile-example
