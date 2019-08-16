FROM python:3.6-alpine

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
	&& echo "https://mirrors.aliyun.com/alpine/v3.10/main" >/etc/apk/repositories \
	&& echo "https://mirrors.aliyun.com/alpine/v3.10/community" >>/etc/apk/repositories \
	&& apk add --no-cache tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN set -ex \
	&& mkdir /root/.pip \
	&& echo '[global]' > /root/.pip/pip.conf \
	&& echo 'index-url = http://mirrors.aliyun.com/pypi/simple/' >> /root/.pip/pip.conf \
	&& echo '[install]' >> /root/.pip/pip.conf \
	&& echo 'trusted-host=mirrors.aliyun.com' >> /root/.pip/pip.conf