SET sql-client.execution.result-mode=tableau;

SET execution.runtime-mode=streaming;

SET table.local-time-zone=Asia/Shanghai;

SET table.sql-dialect=default;

SET table.dml-sync=true;

SET table.exec.sink.upsert-materialize = none;

CREATE CATALOG fluss_catalog WITH (
  'type' = 'fluss',
  'bootstrap.servers' = 'fluss:9123'
);

use catalog fluss_catalog;

