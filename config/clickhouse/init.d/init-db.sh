#!/bin/bash
set -e

clickhouse client -u $CLH_USER --password $CLH_PASSWORD -n <<-EOSQL
    CREATE TABLE IF NOT EXISTS docker_logs (
        id UUID DEFAULT generateUUIDv4(),
        message String,
        level String,
        container_name String,
        container_id String,
        image String,
        container_created_at DateTime64(6,'UTC'),
        timestamp DateTime64(6,'UTC')
    ) ENGINE = ReplacingMergeTree
    PRIMARY KEY id;
EOSQL