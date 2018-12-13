#!/bin/bash

d_name="kafka"

dirty_ip=$(hostname -i)
ip=$(echo -e "$dirty_ip" | sed 's/^[ \t]*//;s/[ \t]*$//')

echo "HOST IP is '${ip}'"
docker rm -f $d_name
docker run -h kafka.server -p 9092:9092 -p 2181:2181 -e HOST_IP=${ip} --name=$d_name --privileged=true --detach=true   -d kafka:latest
