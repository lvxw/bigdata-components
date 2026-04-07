#!/bin/bash

spark-sql --master yarn \
   --conf spark.driver.userClassPathFirst=true \
   --conf spark.executor.userClassPathFirst=true \
   --conf spark.sql.catalog.paimon_catalog=org.apache.paimon.spark.SparkCatalog \
   --conf spark.sql.catalog.paimon_catalog.warehouse=hdfs:///warehouse/tablespace/managed/hive \
   --conf spark.sql.catalog.paimon_catalog.metastore=hive \
   --conf spark.sql.catalog.paimon_catalog.uri=thrift://hive:9083 \
   --conf spark.sql.extensions=org.apache.paimon.spark.extensions.PaimonSparkSessionExtensions \
   --conf spark.sql.defaultCatalog=paimon_catalog