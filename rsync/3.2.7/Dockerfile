FROM alpine:3.17

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.17/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.17/community" >>/etc/apk/repositories \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN set -ex \
    && apk add --no-cache rsync

COPY rsyncd.conf /etc/
COPY docker-entrypoint.sh /usr/local/bin/

CMD ["docker-entrypoint.sh"]
