# Docker

## Netoworking

```sh
$ docker run -it -d -p 80 conatiner-id
```

## Enter to Container
```sh
$ docker exec -it [container-id] bash
```

## Docker Stop
```sh
$ docker stop my_container
```

## Run Container
```sh
$ docker run -it -d --network host --name container_name image_name bash
```


## Issue

Cannot connect to the Docker daemon. Is the docker daemon running on this host?

## Solution

```sh
$ sudo service docker stop
$ sudo service docker start 
```

## Docker File Example I C++
```sh
# Get the base Ubuntu image from Docker Hub
FROM ubuntu:latest
 
# Update apps on the base image
RUN apt-get -y update && apt-get install -y
 
# Install the Clang compiler
RUN apt-get -y install clang
 
# Copy the current folder which contains C++ source code to the Docker image under /usr/src
COPY . /usr/src/dockertest1
 
# Specify the working directory
WORKDIR /usr/src/dockertest1
 
# Use Clang to compile the Test.cpp source file
RUN clang++ -o Test Test.cpp
 
# Run the output program from the previous step
CMD ["./Test"]
```

## Docker File Example II C++
```sh
FROM fedora:27
RUN dnf update -y
RUN dnf install -y gcc-c++ \
                  make \
                  openssl-devel \
                  libev \
                  jsoncpp-devel \
                  opencv 

COPY . /root
WORKDIR /root
WORKDIR /root/AMQP-CPP
RUN make clean
RUN make
RUN make install
WORKDIR /root/SW_Baumer_GAPI_SDK_Linux_v2.9.0
RUN dnf install -y baumer-gapi-sdk-linux-v2.9.0.18905-Fedora-27-x86-64.rpm
WORKDIR /root
CMD ["./Mad"]
```

## Directory 
```sh
$ ls
```
```sh
Dockerfile		app			requirements.txt
```
## Build
Now run the build command. This creates a Docker image, which we’re going to name using the --tag option. Use -t if you want to use the shorter option.

```sh
$ docker build --tag=friendlyhello .
```

## list images

```sh
$ docker image ls
```

## list containers
```sh
$ docker ps
```

## remove a image
```sh
$ docker rmi -f image_name
```

## remove a container
```sh
$ docker rm ti_mad
```

## remove untaged images <none>
 ```sh
 docker rmi -f $(docker images --filter "dangling=true" -q --no-trunc)
```
 
## Docker log
```sh
$ docker logs container_name -f
```
