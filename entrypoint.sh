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

case $1 in
scala)
  export MAVEN_OPTS="-Xss64m -Xmx2g -XX:ReservedCodeCacheSize=1g -Dorg.slf4j.simpleLogger.defaultLogLevel=WARN"
  export MAVEN_CLI_OPTS="--no-transfer-progress"
  ./build/mvn $MAVEN_CLI_OPTS -Paarch64 -Pyarn -Phive -Phive-thriftserver -Pkinesis-asl -Pmesos -Pkubernetes -Pdocker-integration-tests --fail-at-end -Dmaven.test.failure.ignore=true test
  ;;
build)
  echo "build start"
  ;;
python)
  echo "python test start"
  ;;
*)
  echo "Unknow, try test.sh"
  wget https://raw.githubusercontent.com/Yikun/spark-arm-docker/main/test.sh
  chmod +x ./test.sh
  ./test.sh
  ;;
esac
