FROM changel/alpine:3.8

MAINTAINER changel <changel@changel.cn>

ARG ETC_VERSION=3.3.13
RUN set -ex \
    && wget https://github.com/etcd-io/etcd/releases/download/v${ETC_VERSION}/etcd-v${ETC_VERSION}-linux-amd64.tar.gz \
    && tar zxf etcd-v${ETC_VERSION}-linux-amd64.tar.gz \
    && rm -f etcd-v${ETC_VERSION}-linux-amd64.tar.gz \
    && chown root:root etcd-v${ETC_VERSION}-linux-amd64/etcd* \
    && mv etcd-v${ETC_VERSION}-linux-amd64/etcd* /usr/local/bin/ \
    && rm -rf etcd-v${ETC_VERSION}-linux-amd64 \
    && mkdir -p /var/lib/etcd 

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["etcd"]