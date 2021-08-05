#!/bin/bash
set -ex

export MAVEN_OPTS="-Xss64m -Xmx2g -XX:ReservedCodeCacheSize=1g -Dorg.slf4j.simpleLogger.defaultLogLevel=WARN"
export MAVEN_CLI_OPTS="--no-transfer-progress"
./build/mvn $MAVEN_CLI_OPTS -Paarch64 -Pyarn -Phive -Phive-thriftserver -Pkinesis-asl -Pmesos -Pkubernetes -Pdocker-integration-tests --fail-at-end -Dmaven.test.failure.ignore=true test -pl :spark-unsafe_2.12
