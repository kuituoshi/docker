FROM changel/openjdk:8-jre

MAINTAINER changel <changel@changel.cn>

# install tomcat
ENV TOMCAT_MAIN_VERSION=9
ENV TOMCAT_VERSION=9.0.58
ENV LANG="en_US.UTF-8" CATALINA_HOME="/usr/local/tomcat"
ENV PATH="${CATALINA_HOME}/bin:$PATH"
RUN set -ex \
	&& apk add --no-cache curl 'su-exec>=0.2' \
	&& mkdir -p ${CATALINA_HOME} \
	&& cd ${CATALINA_HOME} \
	&& curl -sSL https://mirrors.aliyun.com/apache/tomcat/tomcat-${TOMCAT_MAIN_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -o tomcat.tar.gz \
	&& tar -xvf tomcat.tar.gz --strip-components=1 \
	&& addgroup -g 1000 tomcat \
	&& adduser -G tomcat -h ${CATALINA_HOME} -D -u 1000 tomcat \
	&& chown -R tomcat:tomcat ${CATALINA_HOME} \
	&& rm bin/*.bat \
	&& rm -f tomcat.tar.gz \
	&& rm -rf webapps/* \
	&& apk del curl \
	&& mkdir webapps/ROOT \
	&& rm -rf /tmp/*

# SETUP log to console
RUN set -ex \
	&& ln -sf /dev/stdout ${CATALINA_HOME}/logs/INFO.log \
	&& ln -sf /dev/stdout ${CATALINA_HOME}/logs/WARN.log \
	&& ln -sf /dev/stdout ${CATALINA_HOME}/logs/DEBUG.log \
	&& ln -sf /dev/stderr ${CATALINA_HOME}/logs/ERROR.log

RUN set -ex \
	&& mkdir /docker-entrypoint-init.d
	
WORKDIR ${CATALINA_HOME}

COPY server.xml conf/
COPY run.sh /usr/local/bin/

CMD ["run.sh"]