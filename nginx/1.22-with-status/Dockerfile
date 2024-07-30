FROM nginx:1.22-alpine

MAINTAINER changel <changel@changel.cn>

# install timezone
RUN set -ex \
	&& echo "https://mirrors.aliyun.com/alpine/v3.16/main" >/etc/apk/repositories \
	&& echo "https://mirrors.aliyun.com/alpine/v3.16/community" >>/etc/apk/repositories \
	&& apk add --no-cache tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY html /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/
