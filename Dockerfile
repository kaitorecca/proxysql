FROM debian:stretch
MAINTAINER Tai Tran <hongtai91@gmail.com>

ENV VERSION 2.0.0-rc2
ARG repository="deb http://repo.yandex.ru/clickhouse/deb/stable/ main/"
ARG version=18.14.11
ARG gosu_ver=1.10


RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        apt-transport-https \
        dirmngr \
        gnupg \
    && mkdir -p /etc/apt/sources.list.d \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv E0C56BD4 \
    && echo $repository > /etc/apt/sources.list.d/clickhouse.list
RUN apt-get update && \
	apt-get install -y nano iputils-ping && \
    apt-get install -y wget mysql-client && \
    wget https://github.com/sysown/proxysql/releases/download/v${VERSION}/proxysql-rc2_2.0.0-clickhouse-debian9_amd64.deb -O /opt/proxysql_${VERSION}-clickhouse-debian9_amd64.deb && \
    dpkg -i /opt/proxysql_${VERSION}-clickhouse-debian9_amd64.deb && \
    env DEBIAN_FRONTEND=noninteractive \
        apt-get install --allow-unauthenticated --yes --no-install-recommends \
            clickhouse-common-static=$version \
            clickhouse-server=$version \
            libgcc-7-dev \
    && rm -rf \
        /var/cache/debconf \
        /tmp/* \
    && apt-get clean && \
    rm -f /opt/proxysql_${VERSION}-clickhouse-debian9_amd64.deb && \
    rm -rf /var/lib/apt/lists/*


COPY load.sql /load.sql
COPY start.sh /start.sh

EXPOSE 6032 6033 6090 6080

ENTRYPOINT ["./start.sh"]
