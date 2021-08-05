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

export MAVEN_OPTS="-Xss64m -Xmx2g -XX:ReservedCodeCacheSize=1g"
export MAVEN_CLI_OPTS="--no-transfer-progress"

case $1 in
scala)
  echo "Scala test start"
  ./build/mvn $MAVEN_CLI_OPTS -Paarch64 -Pyarn -Phive -Phive-thriftserver -Pkinesis-asl -Pmesos -Pkubernetes -Pdocker-integration-tests --fail-at-end -Dmaven.test.failure.ignore=true test
  ;;
build)
  echo "Build start"
  ./build/mvn $MAVEN_CLI_OPTS clean package -DskipTests -Paarch64 -Phadoop-2.7 -Pyarn -Phive -Phive-thriftserver -Pkinesis-asl -Pmesos
  ;;
python)
  echo "PySpark test start"
  ./dev/run-tests --parallelism 1 --modules "pyspark-sql, pyspark-mllib, pyspark-resource, pyspark-core, pyspark-streaming, pyspark-ml, pyspark-pandas, pyspark-pandas-slow"
  ;;
*)
  echo "Unknow, try test.sh"
  wget https://raw.githubusercontent.com/Yikun/spark-arm-docker/main/test.sh
  chmod +x ./test.sh
  ./test.sh
  ;;
esac
