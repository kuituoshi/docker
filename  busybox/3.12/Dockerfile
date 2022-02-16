FROM alpine:3.12

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.12/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.12/community" >>/etc/apk/repositories \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
