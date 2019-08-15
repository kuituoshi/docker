FROM ubuntu:16.04

#base setup
RUN set -ex \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apt update \
    && apt install -y ca-certificates openssl wget tzdata \
    && wget https://www.changel.cn/repo/ubuntu-16.04-sources.list -O /etc/apt/sources.list \
    && apt purge -y ca-certificates openssl wget \
    && apt autoremove -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*