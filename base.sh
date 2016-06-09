#!/bin/bash

if ! grep --quiet "home\.net" /etc/apt/sources.list; then
  sed -i 's/http:\/\//http:\/\/ubuntu-mirror.home.net\//g' /etc/apt/sources.list
fi

apt-get  -y update
apt-get  -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" dist-upgrade

apt-get  -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install apt-transport-https ca-certificates

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' > /etc/apt/sources.list.d/docker.list

apt-get  -y update
apt-get  -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install linux-image-extra-$(uname -r) docker-engine

usermod -aG docker vagrant

if ! grep --quiet "192\.168\.1\.250" /etc/default/docker; then
  echo 'DOCKER_OPTS="--dns 192.168.1.250 -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --insecure-registry 192.168.1.85:5000"' >> /etc/default/docker
  service docker restart
fi

