FROM openjdk:11

RUN apt-get update \
    && apt-get install -y supervisor \
    && apt-get install -y openssh-server

RUN echo "root:root" | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir -p /run/sshd

ARG kafka_tar=kafka_2.11-2.1.0.tgz
RUN mkdir /apps && mkdir -p /var/log/supervisord && mkdir -p /var/log/kafka
COPY ${kafka_tar} /apps
RUN mkdir /apps/kafka
RUN tar -xvf /apps/${kafka_tar} --one-top-level=/apps/kafka  --strip-components 1
COPY supervisord.conf /apps/conf/supervisord.conf

COPY kafka.sh /apps/kafka.sh
RUN chmod +x /apps/kafka.sh

# RUN sed -i -- "s/#advertised.listeners=PLAINTEXT:\/\/your.host.name:9092/advertised.listeners=PLAINTEXT:\/\/0.0.0.0:9092/g" /apps/kafka/config/server.properties


EXPOSE 9092 2181 22

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/apps/conf/supervisord.conf"]
