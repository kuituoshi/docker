FROM fastcn-registry-changsha42.crs.ctyun.cn/library/python:3.10-alpine

RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.20/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.20/community" >>/etc/apk/repositories \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN set -ex \
	&& mkdir /root/.pip \
	&& echo '[global]' > /root/.pip/pip.conf \
	&& echo 'index-url = https://mirrors.huaweicloud.com/repository/pypi/simple/' >> /root/.pip/pip.conf \
	&& echo '[install]' >> /root/.pip/pip.conf \
	&& echo 'trusted-host=mirrors.huaweicloud.com' >> /root/.pip/pip.conf

RUN set -ex \
    && pip3 install modelscope