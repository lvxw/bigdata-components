#!/bin/bash

spark-sql  --master yarn --packages org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.10.1 \
    --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions \
    --conf spark.sql.catalog.iceberg_hive_s3_catalog=org.apache.iceberg.spark.SparkCatalog \
    --conf spark.sql.catalog.iceberg_hive_s3_catalog.type=hive \
    --conf spark.sql.catalog.iceberg_hive_s3_catalog.uri=thrift://hive:9083 \
    --conf spark.sql.catalog.iceberg_hive_s3_catalog.warehouse=s3a://bigdata/lakehouse \
    --conf spark.sql.catalog.iceberg_hive_s3_catalog.s3.path.style.access=true \
    --conf spark.sql.catalog.iceberg_hive_s3_catalog.s3.endpoint=http://minio:9000 \
    --conf spark.sql.catalog.iceberg_hive_s3_catalog.s3.access-key=admin \
    --conf spark.sql.catalog.iceberg_hive_s3_catalog.s3.secret-key=admin123456 \
    --conf spark.sql.catalog.iceberg_hive_s3_catalog.table-default.engine.hive.enabled=true \
    --conf spark.sql.defaultCatalog=iceberg_hive_s3_catalog