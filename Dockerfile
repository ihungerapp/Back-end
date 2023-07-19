#FROM ubuntu:16.04
FROM ubuntu:22.04

LABEL maintainer="ihunger.app@gmail.com"

RUN \ 
 apt-get -y update
# configurar o timezone
RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

ENV TZ="America/Sao_Paulo"

RUN apt-get update
RUN apt-get install -y locales locales-all
ENV LC_ALL pt_BR.UTF-8
ENV LANG pt_BR.UTF-8
ENV LANGUAGE pt_BR.UTF-8

#  bibliotecas adicionais
RUN \
 apt-get -y upgrade && \
 apt-get -y dist-upgrade && \
 apt-get -y install joe wget p7zip-full curl unzip build-essential zlib1g-dev libcurl4-gnutls-dev && \
 apt-get -y install mysecureshell 
 # PostgreSQL
 RUN \
 apt-get -y install libpq-dev && \
 apt-get -y install libcurl3-dev
 #apt-get -y install unixodbc-dev && \
 #apt-get -y install libncurses5 libtommath1 && \
 #ln -s libtommath.so.1 /usr/lib/x86_64-linux-gnu/libtommath.so.0  && \
 #wget -O- https://github.com/FirebirdSQL/firebird/releases/download/R3_0_5/Firebird-3.0.5.33220-0.amd64.tar.gz|tar -zxC /tmp


RUN \ 
 apt-get -y autoremove && \
 apt-get -y autoclean 

WORKDIR /root
COPY deploy deploy 

# Comandos no container

CMD chmod +x ./deploy/Server ;ln -s /deploy/Server ; ./deploy/Server

#ENV ODBC_SERVER tcp:database,1401
#ENV ODBC_NAME BANCO
#ENV PASERVER_PASSWORD 1234
# portas
EXPOSE 8081
#EXPOSE 64211 8081
