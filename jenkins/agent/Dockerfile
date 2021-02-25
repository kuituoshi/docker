FROM changel/alpine:3.12-ssh

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && apk add --no-cache docker-cli \
    && mkdir /root/.docker

#install git and svn and so on
RUN set -ex \
    && apk add --no-cache openjdk8-jre ansible git subversion sshpass \
    && ln -sf /usr/bin/python3 /usr/bin/python

# config pip
RUN set -ex \
	&& mkdir /root/.pip \
    && echo '[global]' > /root/.pip/pip.conf \
    && echo 'index-url = http://mirrors.aliyun.com/pypi/simple/' >> /root/.pip/pip.conf \
    && echo '[install]' >> /root/.pip/pip.conf \
    && echo 'trusted-host=mirrors.aliyun.com' >> /root/.pip/pip.conf