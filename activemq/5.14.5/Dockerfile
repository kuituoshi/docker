FROM changel/alpine:3.8

MAINTAINER changel <changel@changel.cn>

ENV ACTIVEMQ_VERSION 5.14.5
ENV ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION
ENV ACTIVEMQ_TCP=61616 ACTIVEMQ_AMQP=5672 ACTIVEMQ_STOMP=61613 ACTIVEMQ_MQTT=1883 ACTIVEMQ_WS=61614 ACTIVEMQ_UI=8161
ENV ACTIVEMQ_HOME /usr/local/activemq

RUN set -ex \
    && addgroup -S activemq && adduser -u 200 -S -G activemq activemq \
    && apk add --no-cache openjdk8-jre-base 'su-exec>=0.2' \
    && apk add --no-cache --virtual .build-deps curl \
    && curl  https://www.changel.cn/repo/activemq/$ACTIVEMQ-bin.tar.gz > activemq.tar.gz \
    && mkdir -p $ACTIVEMQ_HOME \
    && tar zxvf  activemq.tar.gz -C ${ACTIVEMQ_HOME} --strip-components=1 \
    && chown -R activemq:activemq ${ACTIVEMQ_HOME} \
    && rm -f activemq.tar.gz \
    && apk del .build-deps


WORKDIR ${ACTIVEMQ_HOME}/data

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE $ACTIVEMQ_TCP $ACTIVEMQ_AMQP $ACTIVEMQ_STOMP $ACTIVEMQ_MQTT $ACTIVEMQ_WS $ACTIVEMQ_UI

CMD ["docker-entrypoint.sh"]