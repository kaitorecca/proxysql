FROM debian:stretch
MAINTAINER Tai Tran <hongtai91@gmail.com>

ENV VERSION 2.0.0-rc2



RUN apt-get update && \
	apt-get install -y nano iputils-ping && \
    apt-get install -y wget mysql-client && \
    wget https://github.com/sysown/proxysql/releases/download/v${VERSION}/proxysql-rc2_2.0.0-clickhouse-debian9_amd64.deb -O /opt/proxysql_${VERSION}-clickhouse-debian9_amd64.deb && \
    dpkg -i /opt/proxysql_${VERSION}-clickhouse-debian9_amd64.deb


RUN apt-get clean && \
    rm -f /opt/proxysql_${VERSION}-clickhouse-debian9_amd64.deb && \
    rm -rf /var/lib/apt/lists/*


COPY load.sql /load.sql
COPY first.sql /first.sql
COPY start.sh /start.sh

RUN chmod +x start.sh

EXPOSE 6032 6033 6090 6080

ENTRYPOINT ["./start.sh"]
