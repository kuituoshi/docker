FROM fastcn-registry-changsha42.crs.ctyun.cn/hnkz/ansible:2.13.6

RUN set -ex \
    && pip install jmespath \
    && apk add --no-cache ipmitool util-linux

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]