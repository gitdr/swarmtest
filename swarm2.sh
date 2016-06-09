#!/bin/bash

set -e

source /vagrant/base.sh

if ! $( docker ps | grep --quiet "swarm" ); then
  IP=$(ifconfig  | grep -A 1 eth1 | grep -v eth1 | awk '{print $2}' | cut -d ':' -f 2)
  docker run -d -p 4000:4000 192.168.1.85:5000/swarm manage -H :4000 --replication --advertise $IP:4000 consul://10.1.0.2:8500
fi