FROM changel/openjdk:openj9-8-jre

MAINTAINER changel <changel@changel.cn>

# configuration
ENV LANG="en_US.UTF-8" SPRINGBOOT_HOME="/workdir"
RUN set -ex \
	&& mkdir -p ${SPRINGBOOT_HOME}/lib \
	&& addgroup -S -g 1000 java \
	&& adduser -G java -S -D -u 1000 java \
	&& apk add --no-cache 'su-exec>=0.2'

RUN set -ex \
	&& mkdir /docker-entrypoint-init.d

ENV JMX_EXPORTER_VERSION="0.17.0"
RUN set -ex \
	&& mkdir -p ${JAVA_HOME}/lib/jmx \
	&& wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar -O ${JAVA_HOME}/lib/jmx/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar \
	&& echo 'rules:' >${JAVA_HOME}/lib/jmx/jmx_prometheus.yaml \
	&& echo '- pattern: ".*"' >>${JAVA_HOME}/lib/jmx/jmx_prometheus.yaml
	
WORKDIR ${SPRINGBOOT_HOME}

COPY run.sh /usr/local/bin/


CMD ["run.sh"]