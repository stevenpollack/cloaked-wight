#!/bin/bash

RELEASE_NAME=$(lsb_release -c | sed -e 's!\w*:\s*\(\w*\)!\1!g')
DOCKER_DEB="deb https://apt.dockerproject.org/repo ubuntu-$RELEASE_NAME main"

sudo apt-get update  

sudo apt-get install -y \
  apt-transport-https \
  ca-certificates  \
  linux-image-extra-$(uname -r)  

sudo apt-key adv \
  --keyserver hkp://p80.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

sudo echo $DOCKER_DEB > docker.list  
sudo mv -vf docker.list -t /etc/apt/sources.list.d/

sudo apt-get update

# if using 1(2|4).04 need apparmor
if [ ! "$RELEASE_NAME" = "wily" ]; then
  sudo apt-get install -y apparmor
fi

sudo apt-get install -y docker-engine

# add user to docker group to avoid needing to
# run docker with sudo
sudo groupadd docker  
sudo gpasswd -a ${USER} docker
sudo newgrp docker
sudo service docker restart
