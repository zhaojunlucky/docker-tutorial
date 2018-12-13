#!/bin/bash

sleep 10s
echo 'start kafka server'
echo "kafka adverties.listeners ip '${HOST_IP}'"
sed -i -- "s/#advertised.listeners=PLAINTEXT:\/\/your.host.name:9092/advertised.listeners=PLAINTEXT:\/\/${HOST_IP}:9092/g" /apps/kafka/config/server.properties
/apps/kafka/bin/kafka-server-start.sh /apps/kafka/config/server.properties
echo 'done'