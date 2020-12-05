FROM microsoft/mssql-server-linux:2017-latest

WORKDIR /opt/scripts

COPY scripts/* /opt/scripts/

RUN chmod 777 initialize*.sh

