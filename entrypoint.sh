#!/bin/bash
set -x

# Download Spark master code
git init /spark-master-test-maven-arm
cd /spark-master-test-maven-arm
git --version
git fetch --tags --progress -- https://github.com/apache/spark.git +refs/heads/*:refs/remotes/origin/* # timeout=30
git config remote.origin.url https://github.com/apache/spark.git # timeout=30
git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=30
git rev-parse origin/master^{commit} # timeout=30
git checkout master

# Build
./build/mvn clean package -DskipTests -Paarch64 -Phadoop-2.7 -Pyarn -Phive -Phive-thriftserver -Pkinesis-asl -Pmesos

# Test
./build/mvn test -fn -Paarch64 -Phadoop-2.7 -Pyarn -Phive -Phive-thriftserver -Pkinesis-asl -Pmesos
