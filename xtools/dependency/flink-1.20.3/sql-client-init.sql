SET sql-client.execution.result-mode=tableau;

SET execution.runtime-mode=streaming;

SET table.local-time-zone=Asia/Shanghai;

SET table.sql-dialect=default;

SET table.dml-sync=true;

SET table.exec.sink.upsert-materialize = none;

CREATE CATALOG `hive_catalog` WITH (
    'type' = 'hive',
    'default-database' = 'default',
    'hive-conf-dir'='hdfs:///hive/conf'
);

CREATE CATALOG `mysql_catalog` WITH(
  'username' = 'root',
  'password' = 'root',
  'base-url' = 'jdbc:mysql://mysql:3306',
  'default-database' = 'test',
  'type' = 'jdbc'
);

CREATE CATALOG doris_catalog WITH (
    'type' = 'doris',
    'fenodes' = 'doris:48030',
    'jdbc-url' = 'jdbc:mysql://doris:49030',
    'username' = 'root',
    'password' = 'root',
    'default-database' = 'test'
);

CREATE CATALOG `paimon_hive_catalog` WITH (
    'type' = 'paimon',
    'hadoop.dfs.client.use.datanode.hostname' = 'true',
    'uri' = 'thrift://hive:9083',
    'hive-conf-dir' = 'hdfs:///hive/conf',
    'metastore' = 'hive'
);

CREATE CATALOG paimon_hive_s3_catalog WITH (
    'type' = 'paimon',
    'hadoop.dfs.client.use.datanode.hostname' = 'true',
    'uri' = 'thrift://hive:9083',
    'metastore' = 'hive',
    'warehouse' = 's3a://bigdata/lakehouse',
    's3.endpoint' = 'http://minio:9000',
    's3.access-key' = 'admin',
    's3.secret-key' = 'admin123456'
);

CREATE CATALOG paimon_jdbc_s3_catalog WITH (
    'type' = 'paimon',
    'metastore' = 'jdbc',
    'uri' = 'jdbc:mysql://mysql:3306/paimon_catalog',
    'jdbc.user' = 'root',
    'jdbc.password' = 'root',
    'catalog-key'='jdbc',
    'warehouse' = 's3://bigdata/lakehouse',
    's3.endpoint' = 'http://minio:9000',
    's3.access-key' = 'admin',
    's3.secret-key' = 'admin123456'
);

CREATE CATALOG iceberg_hive_catalog WITH (
    'type'='iceberg',
    'catalog-type'='hive',
    'uri'='thrift://hive:9083',
    'clients'='5',
    'property-version'='2',
    'warehouse'='/warehouse/tablespace/managed/hive'
);

CREATE CATALOG iceberg_hive_s3_catalog WITH (
    'type'='iceberg',
    'catalog-type'='hive',
    'uri'='thrift://hive:9083',
    'clients'='5',
    'property-version'='2',
    'warehouse' = 's3a://bigdata/lakehouse',
    's3a.access-key-id' = 'admin',
    's3a.secret-access-key' = 'admin123456',
    's3a.endpoint' = 'http://minio:9000',
    's3a.path-style-access' = 'true'
);

-- CREATE CATALOG fluss_catalog WITH (
--   'type' = 'fluss',
--   'bootstrap.servers' = 'fluss:9123'
-- );

USE CATALOG `hive_catalog`;

LOAD MODULE hive WITH ('hive-version' = '3.1.3');

USE MODULES core, hive;

SET execution.checkpointing.interval = '1 s';
SET table.exec.hive.infer-source-parallelism.max = 4;
SET table.exec.sink.upsert-materialize=NONE;
SET execution.runtime-mode=batch;
SET execution.checkpointing.unaligned.enabled=false;

