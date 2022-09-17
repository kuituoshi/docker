FROM zabbix/zabbix-agent:alpine-6.2-latest

MAINTAINER changel <changel@changel.cn>

USER root

RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.16/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.16/community" >>/etc/apk/repositories

USER zabbix