#!/bin/bash

spark-sql --deploy-mode client --master yarn \
      --conf spark.sql.catalog.spark_catalog.type=hive \
      --conf spark.sql.catalog.iceberg_catalog=org.apache.iceberg.spark.SparkCatalog \
      --conf spark.sql.catalog.iceberg_catalog.type=hive \
      --conf spark.sql.catalog.iceberg_catalog.uri=thrift://hive:9083 \
      --conf spark.sql.catalog.iceberg_catalog.warehouse=hdfs:///warehouse/tablespace/managed/hive