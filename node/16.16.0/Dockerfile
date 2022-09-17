FROM node:16-alpine3.15

MAINTAINER changel <changel@changel.cn>

# install timezone
RUN set -ex \
	&& echo "https://mirrors.aliyun.com/alpine/v3.15/main" >/etc/apk/repositories \
	&& echo "https://mirrors.aliyun.com/alpine/v3.15/community" >>/etc/apk/repositories \
	&& apk add --no-cache tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN set -ex \
    && echo '/usr/local/bin/npm --registry=https://registry.npm.taobao.org --cache=/tmp/cache --disturl=https://npm.taobao.org/dist --userconfig=$HOME/.cnpmrc $@' >/usr/bin/cnpm \
    && chmod 755 /usr/bin/cnpm