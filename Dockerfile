FROM ubuntu:20.04

ARG spark_uid=185

RUN useradd -m -d /home/spark -u ${spark_uid} -g root spark

RUN apt update
RUN DEBIAN_FRONTEND="noninteractive" apt install -y git wget curl openjdk-8-jdk python3 python3-pip && \
  update-alternatives --set java /usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)/jre/bin/java

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN python3.8 -m pip install numpy 'pyarrow<5.0.0' pandas scipy xmlrunner

USER ${spark_uid}
