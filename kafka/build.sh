#!/bin/bash
KAFKA_VERSION="2.1.0"
KAFKA_INSTALL="kafka_2.11-2.1.0.tgz"

if [[ ! -f "${KAFKA_INSTALL}" ]]; then
    wget http://apache.mirrors.lucidnetworks.net/kafka/${KAFKA_VERSION}/${KAFKA_INSTALL}
fi

tag="kafka:latest"
echo "build the kafka Docker as '${tag}'"
docker build --build-arg kafka_tar=${KAFKA_INSTALL} --force-rm=true --rm=true -t ${tag} -f ./Dockerfile .

if [[ $? -ne 0 ]]; then
    echo "fail to build"
    exit 1
fi
