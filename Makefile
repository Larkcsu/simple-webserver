
DOCKERREPO       := endianogino/simple-webserver:1.0

all: simple-webserver container push

simple-webserver:
	docker run --rm -v $(shell pwd):/go/src/github.com/mrahbar/simple-webserver -w /go/src/github.com/mrahbar/simple-webserver -e CGO_ENABLED=0 golang:1.9-stretch go build -a -installsuffix cgo -o simple-webserver simple-webserver.go

container: simple-webserver
	mkdir -p Dockerbuild && \
	cp -f Dockerfile Dockerbuild/ &&\
	cp -f simple-webserver Dockerbuild/ &&\
	docker build -t $(DOCKERREPO) Dockerbuild/

push: container
	docker push $(DOCKERREPO)