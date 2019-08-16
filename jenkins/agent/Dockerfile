FROM changel/alpine:3.9-ssh

MAINTAINER changel <changel@changel.cn>

ENV DOCKER_CLIENT_VERSION 18.06.1-ce
RUN set -ex \
    && apk add --no-cache curl \
    && curl -sSL -o /tmp/docker.tar.gz https://www.changel.cn/repo/docker/docker-linux-${DOCKER_CLIENT_VERSION}.tar.gz \
    && tar zxvf /tmp/docker.tar.gz -C /usr/bin/ \
    && mkdir /root/.docker \
    && rm -f /tmp/docker.tar.gz \
    && apk del curl

#install git and svn and so on
RUN set -ex \
    && apk add --no-cache openjdk8-jre ansible git subversion sshpass python

# config pip
RUN set -ex \
	&& mkdir /root/.pip \
    && echo '[global]' > /root/.pip/pip.conf \
    && echo 'index-url = http://mirrors.aliyun.com/pypi/simple/' >> /root/.pip/pip.conf \
    && echo '[install]' >> /root/.pip/pip.conf \
    && echo 'trusted-host=mirrors.aliyun.com' >> /root/.pip/pip.conf