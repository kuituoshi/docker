FROM adoptopenjdk/openjdk8:alpine-jre

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.13/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.13/community" >>/etc/apk/repositories \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apk add --no-cache ca-certificates