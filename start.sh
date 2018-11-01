#!/bin/bash

proxysql -f --clickhouse-server
service clickhouse-server start

mysql -uadmin -padmin -h 127.0.0.1 -P 6032 > load.sql

"$@"
