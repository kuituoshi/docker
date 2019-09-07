FROM httpd:2.4-alpine

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.10/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.10/community" >>/etc/apk/repositories \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY conf /usr/local/apache2/conf/