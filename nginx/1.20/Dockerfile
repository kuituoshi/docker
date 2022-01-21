FROM nginx:1.20-alpine

MAINTAINER changel <changel@changel.cn>

# install timezone
RUN set -ex \
	&& echo "https://mirrors.aliyun.com/alpine/v3.14/main" >/etc/apk/repositories \
	&& echo "https://mirrors.aliyun.com/alpine/v3.14/community" >>/etc/apk/repositories \
	&& apk add --no-cache tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime