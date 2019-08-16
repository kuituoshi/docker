FROM haproxy:1.8-alpine

MAINTAINER changel <changel@changel.cn>

# install timezone
RUN set -ex \
	&& echo "https://mirrors.aliyun.com/alpine/v3.10/main" >/etc/apk/repositories \
	&& echo "https://mirrors.aliyun.com/alpine/v3.10/community" >>/etc/apk/repositories \
	&& apk add --no-cache tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime