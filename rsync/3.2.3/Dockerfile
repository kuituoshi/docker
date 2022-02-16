FROM changel/alpine:3.14

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && apk add --no-cache rsync openssh-client \
    && mkdir /root/.ssh \
    && chmod 700 /root/.ssh

COPY config /root/.ssh/
