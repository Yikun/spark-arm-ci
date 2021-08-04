FROM ubuntu:20.04

ARG spark_uid=185

RUN useradd -m -d /home/spark -u ${spark_uid} -g root spark

RUN apt update
RUN DEBIAN_FRONTEND="noninteractive" apt install -y git wget curl openjdk-8-jdk && \
  update-alternatives --set java /usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)/jre/bin/java

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

USER ${spark_uid}
