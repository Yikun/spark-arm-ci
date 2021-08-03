FROM ubuntu:20.04

RUN apt update
RUN DEBIAN_FRONTEND="noninteractive" apt install -y git curl openjdk-8-jdk && \
  update-alternatives --set java /usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)/jre/bin/java

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
