#!/bin/bash

spark-sql --master yarn \
  --conf spark.driver.userClassPathFirst=true \
  --conf spark.executor.userClassPathFirst=true \
  --conf spark.sql.catalog.paimon_catalog=org.apache.paimon.spark.SparkCatalog \
  --conf spark.sql.catalog.paimon_catalog.warehouse=s3a://bigdata/lakehouse\
  --conf spark.sql.catalog.paimon_catalog.s3.path.style.access=true \
  --conf spark.sql.catalog.paimon_catalog.s3.endpoint=http://minio:9000 \
  --conf spark.sql.catalog.paimon_catalog.s3.access-key=admin \
  --conf spark.sql.catalog.paimon_catalog.s3.secret-key=admin123456 \
  --conf spark.sql.catalog.paimon_catalog.metastore=hive \
  --conf spark.sql.catalog.paimon_catalog.uri=thrift://hive:9083 \
  --conf spark.sql.extensions=org.apache.paimon.spark.extensions.PaimonSparkSessionExtensions \
  --conf spark.hadoop.fs.s3a.access.key=admin \
  --conf spark.hadoop.fs.s3a.secret.key=admin123456 \
  --conf spark.hadoop.fs.s3a.endpoint=http://minio:9000 \
  --conf spark.hadoop.fs.s3a.path.style.access=true