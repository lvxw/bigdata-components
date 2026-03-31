#!/bin/bash

spark-sql --master yarn --jars  hdfs:///tmp/paimon-spark-3.5-1.3.1.jar \
   --conf spark.driver.userClassPathFirst=true \
   --conf spark.executor.userClassPathFirst=true \
   --conf spark.sql.catalog.paimon_catalog=org.apache.paimon.spark.SparkCatalog \
   --conf spark.sql.catalog.paimon_catalog.warehouse=hdfs:///hive/conf \
   --conf spark.sql.catalog.paimon_catalog.metastore=hive \
   --conf spark.sql.catalog.paimon_catalog.uri=thrift://hive:9083 \
   --conf spark.sql.extensions=org.apache.paimon.spark.extensions.PaimonSparkSessionExtensions \
   -i ${SPARK_HOME}/conf/init.sql