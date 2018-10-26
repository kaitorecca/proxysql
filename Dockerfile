FROM debian:stretch
MAINTAINER Tai Tran <hongtai91@gmail.com>

ENV VERSION 1.4.12

RUN apt-get update && \
	apt-get install -y nano iputils-ping && \
    apt-get install -y wget mysql-client && \
    wget https://github.com/sysown/proxysql/releases/download/v${VERSION}/proxysql_${VERSION}-debian9_amd64.deb -O /opt/proxysql_${VERSION}-debian9_amd64.deb && \
    dpkg -i /opt/proxysql_${VERSION}-debian9_amd64.deb && \
    rm -f /opt/proxysql_${VERSION}-debian9_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/proxysql
EXPOSE 6032 6033 6090

ENTRYPOINT ["proxysql", "-f", "--clickhouse-server"]
