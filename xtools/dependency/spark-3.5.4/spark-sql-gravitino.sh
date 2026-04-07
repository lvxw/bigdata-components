#!/bin/bash

spark-sql --deploy-mode client --master yarn \
  --conf spark.plugins="org.apache.gravitino.spark.connector.plugin.GravitinoSparkPlugin" \
  --conf spark.sql.gravitino.uri=http://gravitino:8090 \
  --conf spark.sql.gravitino.metalake=lakehouse_metalake \
  --conf spark.sql.gravitino.enablePaimonSupport=true \
  --conf spark.sql.gravitino.client.socketTimeoutMs=60000 \
  --conf spark.sql.gravitino.client.connectionTimeoutMs=60000 \
  --conf spark.sql.warehouse.dir=hdfs:///warehouse/tablespace/managed/hive