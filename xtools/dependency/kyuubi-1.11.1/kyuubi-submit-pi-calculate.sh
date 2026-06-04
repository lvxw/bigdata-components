#!/bin/bash

curl --location --request POST 'http://kyuubi:10099/api/v1/batches' \
  --header 'Content-Type: application/json' \
  --data "{
    \"batchType\": \"SPARK\",
    \"name\": \"Spark Pi\",
    \"className\": \"org.apache.spark.examples.SparkPi\",
    \"resource\": \"${SPARK_HOME}/examples/jars/spark-examples_2.12-${SPARK_VERSION}.jar\",
    \"conf\": {
      \"spark.master\": \"yarn\",
      \"spark.submit.deployMode\": \"cluster\"
    }
  }"