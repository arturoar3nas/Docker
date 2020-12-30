# Docker

## Fast run

```sh
$ docker run -it --rm fedora bash
```

## Fast exec command

```sh 
docker exec thirsty_shtern rabbitmqadmin get queue=amq.gen-9PxMO4kJaypRp5lgVKEIIw ackmode=ack_requeue_true count=10
```

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
another example
```sh
$ docker run -it -d -p 5000:5000 -v /root/Molduras/MCA:/usr/src/mca -v /root/Molduras/MCA_Test:/usr/src/app/ --network host --name mca_test_dev mca_test bash
```
run with GDB
```sh
docker run -it -d --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v /root/Molduras/MCA_DEV:/root/mca --network host --name molduras_mca_gdb molduras_mca_dev bash
```
run with shared memory boost
```sh
docker run -it -d --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v /home/arturo/Projects/Pyro/pyro_stream:/root/dev --network host --ipc=host --name pyro_stream_dev_1 pyro_stream_dev bash
```

## Issue

Cannot connect to the Docker daemon. Is the docker daemon running on this host?

## Solution

```sh
$ sudo service docker stop
$ sudo service docker start 
```

## Issue II

error with dnf install

if getenforce => Enforcing, 
then 
```sh
   sudo setenforce 0
```
validate with :
getenforce (should be Permisive)

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

```sh
$ docker build -f Dockerfile_ -t my_ .
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

## Docker Save Container
```sh
$ docker commit name_container_ name_container:1.0.1
$ docker save -o name_container.tar name_container:1.0.1
```

## Docker Load Image
```sh
$ docker load < name_image.tar.gz
```
## Cpu setup
```sh
$ docker update --cpus 16.0 <container_name>
$ docker update --cpuset-cpus "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" <container_name>
```

## Docker - Shared memory pool

There should be one, "main", container that shares his memory pool, and others, "secondary", containers that use the same memory pool, in order to allow these to share the same pool (boost shared memory).

Example:
* Main container

```
#!bash

docker run -it --name serverSharedMem -v $(pwd):/root/test/:z sharedmemdocker bash
```


* Secondary container

```
#!bash

docker run -it --name clientSharedMem -v $(pwd):/root/test/:z --ipc="container:serverSharedMem" sharedmemdocker bash
```

## Using Rabbitmq

```sh
docker exec thirsty_shtern rabbitmqctl set_log_level debug
docker logs --tail 40 -f  thirsty_shtern
```
