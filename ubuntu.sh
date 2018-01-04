#!/bin/bash

if [ "$(. /etc/os-release; echo $NAME)" != "Ubuntu" ]; then
    echo "This is not ubuntu."
    exit 1
fi

if ! [ -x "$(command -v docker)" ]; then
    sudo apt-get remove docker docker-engine docker.io

    sudo apt-get update -y

    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common -y

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo apt-key fingerprint 0EBFCD88

    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

    sudo apt-get update -y

    sudo apt-get install docker-ce -y

    # sudo docker => docker
    sudo groupadd docker
    sudo usermod -aG docker $USER

    # test
    docker run hello-world

    sleep 5
else
    echo '- docker is already installed. skip.' >&2
fi


if ! [ -x "$(command -v docker-compose)" ]; then
    sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version
else
    echo '- docker-compose is already installed. skip.' >&2
fi


echo '- complete!'
echo '- you have to reboot to run docker without "sudo"'
