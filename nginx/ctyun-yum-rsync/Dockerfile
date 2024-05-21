FROM nginx:1.22-alpine

MAINTAINER changel <changel@changel.cn>

# install timezone
RUN set -ex \
	&& echo "https://mirrors.aliyun.com/alpine/v3.16/main" >/etc/apk/repositories \
	&& echo "https://mirrors.aliyun.com/alpine/v3.16/community" >>/etc/apk/repositories \
	&& apk add --no-cache tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install rsync
RUN set -ex \
    && mkdir -p /data \
    && apk add --no-cache rsync bash procps apache2-utils \
    && ln -sf /bin/bash /bin/sh

COPY files /etc/nginx/
COPY docker-entrypoint.sh /usr/local/bin/
COPY pull_yum_rsync.sh /usr/local/bin/
COPY pull_yum_check.sh /usr/local/bin/

CMD ["docker-entrypoint.sh"]
