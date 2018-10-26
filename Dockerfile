FROM debian:stretch
MAINTAINER Tai Tran <hongtai91@gmail.com>

ENV VERSION 1.4.12

RUN apt-get update && \
	apt-get install -y nano iputils-ping && \
    apt-get install -y wget mysql-client && \
	apt-get install -y proxysql && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 6032 6033 6090

ENTRYPOINT ["proxysql", "--clickhouse-server"]
