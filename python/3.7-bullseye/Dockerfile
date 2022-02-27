FROM python:3.7-slim-bullseye

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && echo 'deb http://mirrors.aliyun.com/debian/ bullseye main non-free contrib' > /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ bullseye main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.aliyun.com/debian-security bullseye-security main' >> /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian-security bullseye-security main' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib' >> /etc/apt/sources.list

RUN set -ex \
	&& mkdir /root/.pip \
	&& echo '[global]' > /root/.pip/pip.conf \
	&& echo 'index-url = http://mirrors.aliyun.com/pypi/simple/' >> /root/.pip/pip.conf \
	&& echo '[install]' >> /root/.pip/pip.conf \
	&& echo 'trusted-host=mirrors.aliyun.com' >> /root/.pip/pip.conf