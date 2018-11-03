#!/bin/bash

proxysql -f --clickhouse-server
service clickhouse-server start

CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    mysql -uadmin -padmin -h 127.0.0.1 -P 6032 > start.sql
    mysql -uadmin -padmin -h 127.0.0.1 -P 6032 > load.sql
else
    mysql -uadmin -padmin -h 127.0.0.1 -P 6032 > load.sql
fi

"$@"
