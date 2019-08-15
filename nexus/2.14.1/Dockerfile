FROM changel/java:jre8.144.jce

ARG NEXUS_VERSION=2.14.1-01
ARG NEXUS_DOWNLOAD_URL=https://www.changel.cn/repo/nexus/nexus-${NEXUS_VERSION}-bundle.tar.gz

# configure nexus runtime
ENV SONATYPE_DIR=/usr/local
ENV NEXUS_HOME=${SONATYPE_DIR}/nexus \
    SONATYPE_WORK=${SONATYPE_DIR}/sonatype-work

RUN set -ex \
	&& apk add --no-cache 'su-exec>=0.2' \
    && apk add --no-cache --virtual .build-deps curl \
    && curl  ${NEXUS_DOWNLOAD_URL} > nexus-${NEXUS_VERSION}-bundle.tar.gz \
    && mkdir -p $NEXUS_HOME \
    && tar zxf  nexus-${NEXUS_VERSION}-bundle.tar.gz -C $NEXUS_HOME --strip-components=1 \
    && rm -f nexus-${NEXUS_VERSION}-bundle.tar.gz \
    && chown -R root:root ${NEXUS_HOME} \
    && addgroup -S nexus && adduser -u 200 -h ${SONATYPE_WORK} -S -G nexus nexus \
    && apk del .build-deps


ENV MAX_HEAP 768m
ENV MIN_HEAP 256m

COPY docker-entrypoint.sh /usr/local/bin/

VOLUME ${SONATYPE_WORK}

EXPOSE 8081

CMD ["docker-entrypoint.sh"]