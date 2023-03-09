FROM python:3.11-alpine3.17

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
	&& echo "https://repo.huaweicloud.com/alpine/v3.17/main" >/etc/apk/repositories \
	&& echo "https://repo.huaweicloud.com/alpine/v3.17/community" >>/etc/apk/repositories \
	&& apk add --no-cache tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN set -ex \
	&& mkdir /root/.pip \
	&& echo '[global]' > /root/.pip/pip.conf \
	&& echo 'index-url = https://repo.huaweicloud.com/repository/pypi/simple/' >> /root/.pip/pip.conf \
	&& echo 'trusted-host=repo.huaweicloud.com' >> /root/.pip/pip.conf