FROM alpine:3.17

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.17/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.17/community" >>/etc/apk/repositories \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && mkdir -p /opt/iso

ADD Kylin-Server-10-SP2-aarch64-Release-Build09-20210524.iso /opt/iso/
