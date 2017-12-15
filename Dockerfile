FROM centos:7.3.1611
MAINTAINER tpham

USER root

ARG clickhouse_rpm_version="1.1.54310-3.el7.x86_64"
ARG work_dir=/home/bihasi/clickhouse

WORKDIR ${work_dir}

RUN yum -y clean all && \
    curl -s https://packagecloud.io/install/repositories/altinity/clickhouse/script.rpm.sh | bash && \
    yum -y install clickhouse-server-${clickhouse_rpm_version}

WORKDIR /

COPY etc/clickhouse-server/config.xml /etc/clickhouse-server/config.xml
COPY etc/clickhouse-server/users.xml /etc/clickhouse-server/users.xml
ENV CLICKHOUSE_CONFIG=/etc/clickhouse-server/config.xml

EXPOSE 9000 8123 9009

ENTRYPOINT exec clickhouse-server --config=${CLICKHOUSE_CONFIG}
