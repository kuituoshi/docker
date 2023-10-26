FROM changel/ansible:6.6.0

RUN set -ex \
    && pip install jmespath \
    && apk add --no-cache ipmitool

COPY docker-entrypoint.sh /usr/local/bin/
COPY id_ctyun /root/.ssh/id_rsa

ENTRYPOINT ["docker-entrypoint.sh"]