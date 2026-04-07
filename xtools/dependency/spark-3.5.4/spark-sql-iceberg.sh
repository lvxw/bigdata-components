#!/bin/bash

spark-sql  --master yarn --packages org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.10.1 \
   --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions \
   --conf spark.sql.catalog.iceberg_hive_catalog=org.apache.iceberg.spark.SparkCatalog \
   --conf spark.sql.catalog.iceberg_hive_catalog.type=hive \
   --conf spark.sql.catalog.iceberg_hive_catalog.uri=thrift://hive:9083 \
   --conf spark.sql.catalog.iceberg_hive_catalog.warehouse=hdfs:///warehouse/tablespace/managed/hive \
   --conf spark.sql.catalog.iceberg_hive_catalog.table-default.engine.hive.enabled=true \
   --conf spark.sql.defaultCatalog=iceberg_hive_catalog

