#!/bin/bash

if [ "$(. /etc/os-release; echo $NAME)" != "Ubuntu" ]; then
    echo "This is not ubuntu."
    exit 1
fi

if [ -x "$(command -v docker)" ]; then
    echo 'Error: docker is already installed.' >&2
    exit 1
fi



sudo apt-get remove docker docker-engine docker.io

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce

# sudo docker => docker
sudo groupadd docker
sudo usermod -aG docker $USER

# test
sudo docker run hello-world



if [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: docker-compose is already installed.' >&2
  exit 1
fi

sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
