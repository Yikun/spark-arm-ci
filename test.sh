#!/bin/bash
set -ex

./build/mvn -fn -Paarch64 -Phadoop-2.7 -Pyarn -Phive -Phive-thriftserver -Pkinesis-asl -Pmesos --fail-at-end -Dmaven.test.failure.ignore=true test -pl :spark-core_2.12,:spark-streaming_2.12,:spark-sql_2.12
