#!/bin/bash

spark-sql --master yarn --packages org.apache.fluss:fluss-spark-3.5_2.12:0.9.0-incubating,org.apache.fluss:fluss-fs-hdfs:0.9.0-incubating \
  --conf spark.sql.catalog.fluss_catalog=org.apache.fluss.spark.SparkCatalog \
  --conf spark.sql.catalog.fluss_catalog.bootstrap.servers=fluss:9123 \
  --conf spark.sql.extensions=org.apache.fluss.spark.FlussSparkSessionExtensions \
   --conf spark.sql.defaultCatalog=fluss_catalog