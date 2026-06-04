SET sql-client.execution.result-mode=tableau;

SET execution.runtime-mode=streaming;

SET table.local-time-zone=Asia/Shanghai;

SET table.sql-dialect=default;

SET table.dml-sync=true;

SET table.exec.sink.upsert-materialize = none;

USE CATALOG `paimon_catalog`;

SET execution.runtime-mode=batch;
SET execution.checkpointing.unaligned.enabled=false;