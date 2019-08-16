FROM node:10.3.0-alpine

MAINTAINER changel <changel@changel.cn>

# install timezone
RUN set -ex \
	&& echo "https://mirrors.aliyun.com/alpine/v3.7/main" >/etc/apk/repositories \
	&& echo "https://mirrors.aliyun.com/alpine/v3.7/community" >>/etc/apk/repositories \
	&& apk add --no-cache tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN set -ex \
    && echo '/usr/local/bin/npm --registry=https://registry.npm.taobao.org --cache=/tmp/cache --disturl=https://npm.taobao.org/dist --userconfig=$HOME/.cnpmrc $@' >/usr/bin/cnpm \
    && chmod 755 /usr/bin/cnpm \
    && cnpm install -g pm2