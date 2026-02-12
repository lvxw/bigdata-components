#!/bin/bash
set -e

clickhouse client --user default --password default -n <<-EOSQL
CREATE DATABASE IF NOT EXISTS adsdb;

CREATE TABLE IF NOT EXISTS adsdb.ads_label_user_all_data_realtime_vertical_d(
  pid String,
  label_code String,
  label_value String,
  log_time Int64,
  update_time Int64,
  day String
)
ENGINE = MergeTree
ORDER BY pid;

insert into adsdb.ads_label_user_all_data_realtime_vertical_d values('1001125096', 'k000430', '中国-广东', 1715615661689, 1715615662237, '2024-05-13');
insert into adsdb.ads_label_user_all_data_realtime_vertical_d values('1001125097', 'k000430', '中国-广西', 1715615661689, 1715615662237, '2024-05-13');

EOSQL