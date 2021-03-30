# Docker

## Issue

cgroups: cgroup mountpoint does not exist: unknown

```sh
sudo mkdir /sys/fs/cgroup/systemd
sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
```

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

## Add volume to container for debug purpose
```sh
$ docker rename container_name container_name_dev
$ docker ps -a
$ docker inspect container_name_dev
$ docker commit <hash> container_name_image
$ docker images
$ docker run -it -d -w /root/dev -v /mnt/some_name:/root/dev  -v /mnt/videos:/var/videos -v /etc/some_config:/etc/some_config --network host --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --name container_name container_image:latest bash
```

## Docker Stop
```sh
$ docker stop my_container
```

## Docker Stop All
```sh
$ docker stop $(docker ps -q)
```

## Run Container
```sh
$ docker run -it -d --network host --name container_name image_name bash
```
another example
```sh
$ docker run -it -d -p 5000:5000 -v /root/somepath:/usr/src/anotherpath -v /root/somepath:/usr/src/anotherpath --network host --name container_name container_image bash
```

GDB + change work dir + add volumenes
```
docker run -it -d -w /root/dev -v /mnt/dev:/root/dev  -v /mnt/videos:/var/videos -v /etc/path:/etc/path --network host -w /root/dev --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --name container_dev container_dev:latest bash
```
run with GDB
```sh
docker run -it -d --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v /root/somepath:/root/anotherpath --network host --name container_name container_image bash
```
run with shared memory boost
```sh
docker run -it -d --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v /home/somepath:/root/dev --network host --ipc=host --name container_name container_image bash
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

## Removing all stopped containers #
```
$ docker container prune
```
## remove a image
```sh
$ docker rmi -f image_name
```

## remove image by tag
```sh
$ docker rmi $(docker images | grep tag | tr -s ' ' | cut -d ' ' -f 3)
```

## cleaning images by date
```sh
$ docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}'
$ docker image prune -a --filter "until=2020-09-07T00:00:00"

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

## Using pgadmin4

```sh
docker run -it --rm  -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com' -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret' -p 8888:80  dpage/pgadmin4 bash
```
