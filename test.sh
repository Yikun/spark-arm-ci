#!/bin/bash
set -ex

./build/mvn clean package -DskipTests -Paarch64 -Phadoop-2.7 -Pyarn -Phive -Phive-thriftserver -Pkinesis-asl -Pmesos

./build/mvn -fn -Paarch64 -Phadoop-2.7 -Pyarn -Phive -Phive-thriftserver -Pkinesis-asl -Pmesos --fail-at-end test -pl :spark-core_2.12,:spark-streaming_2.12,:spark-sql_2.12
