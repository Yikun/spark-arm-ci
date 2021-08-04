FROM ubuntu:20.04

ARG spark_uid=185

RUN useradd -u ${spark_uid} -g root spark

RUN apt update
RUN DEBIAN_FRONTEND="noninteractive" apt install -y wget git curl openjdk-8-jdk && \
  update-alternatives --set java /usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)/jre/bin/java

RUN wget https://raw.githubusercontent.com/Yikun/spark-arm-docker/dynamic/entrypoint.sh;mv entrypoint.sh /
RUN chmod a+rwx /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

USER ${spark_uid}
