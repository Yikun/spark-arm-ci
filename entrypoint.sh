#!/bin/bash
set -ex

whoami

git init ~/spark-master-test-maven-arm
cd ~/spark-master-test-maven-arm
git --version
git fetch --tags --progress -- https://github.com/apache/spark.git +refs/heads/*:refs/remotes/origin/* # timeout=30
git config remote.origin.url https://github.com/apache/spark.git # timeout=30
git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=30
git rev-parse origin/master^{commit} # timeout=30
git checkout master

cd ~/spark-master-test-maven-arm

./build/mvn clean package -DskipTests -Paarch64 -Phadoop-3.2 -Pyarn -Phive -Phive-2.3 -Phive-thriftserver -Pkinesis-asl -Pmesos
./build/mvn test -Paarch64 -Phadoop-3.2 -Pyarn -Phive -Phive-2.3 -Phive-thriftserver -Pkinesis-asl -Pmesos --fail-at-end -Dmaven.test.failure.ignore=true

