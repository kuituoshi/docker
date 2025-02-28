FROM fastcn-registry-changsha42.crs.ctyun.cn/library/alpine:3.10

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && apk add --no-cache rsync

COPY rsyncd.conf /etc/
COPY docker-entrypoint.sh /usr/local/bin/

CMD ["docker-entrypoint.sh"]
