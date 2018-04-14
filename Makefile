BuildStamp = main.BuildStamp=$(shell date '+%Y-%m-%d_%I:%M:%S%p')
GitHash    = main.GitHash=$(shell git rev-parse HEAD)
Version    = main.Version=$(shell git describe --abbrev=0 --tags --always)
Target     = $(shell basename $(abspath $(dir $$PWD)))

ifeq ($(OS),Windows_NT)
    OSName = windows
else
    OSName = $(shell echo $(shell uname -s) | tr '[:upper:]' '[:lower:]')
endif

all: ${OSName}

${OSName}:
	GOOS=$@ GOARCH=amd64 go build -v -o release/${Target}-$@ -ldflags "-s -w -X ${BuildStamp} -X ${GitHash} -X ${Version}"

authors:
	printf "Authors\n=======\n\nProject's contributors:\n\n" > AUTHORS.md
	git log --raw | grep "^Author: " | cut -d ' ' -f2- | cut -d '<' -f1 | sed 's/^/- /' | sort | uniq >> AUTHORS.md

clean:
	-rm -rf release *.db *.db-journal
