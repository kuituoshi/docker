FROM changel/openjdk:openj9-8-jre

MAINTAINER changel <changel@changel.cn>


#install rocketmq
ARG ROCKETMQ_VERSION=4.9.3

ENV ROCKETMQ_HOME=/usr/local/rocketmq \
	ROCKETMQ_DATA=/data/rocketmq

ENV PATH=${PATH}:${ROCKETMQ_HOME}/bin

RUN set -ex \
    && apk add --no-cache curl 'su-exec>=0.2' \
    && mkdir -p ${ROCKETMQ_DATA} \
    && addgroup -g 1000 java \
	&& adduser -G java -D -h ${ROCKETMQ_DATA} -u 1000 java \
    && curl -L https://archive.apache.org/dist/rocketmq/${ROCKETMQ_VERSION}/rocketmq-all-${ROCKETMQ_VERSION}-bin-release.zip -o rocketmq.zip \
    && unzip rocketmq.zip -d /usr/local \
    && mv /usr/local/rocketmq-${ROCKETMQ_VERSION} ${ROCKETMQ_HOME} \
    && rm -f rocketmq.zip \
    && apk del curl

ENV JAVA_OPT_EXT -Xms512m -Xmx512m -Xmn128m

WORKDIR ${ROCKETMQ_HOME}

COPY run.sh /usr/local/bin/

EXPOSE 9876 10909 10911 10912 10913

CMD ["run.sh"]