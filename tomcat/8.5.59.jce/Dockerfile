FROM changel/java:jre8.144.jce

MAINTAINER changel <changel@changel.cn>

# install tomcat
ENV LANG="en_US.UTF-8" CATALINA_HOME="/usr/local/tomcat"
ENV PATH="${CATALINA_HOME}/bin:$PATH"
ENV JAVA_OPTS="-server -Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF8 -Djava.security.egd=file:/dev/./urandom"
RUN set -ex \
	&& apk add --no-cache curl \
	&& mkdir -p ${CATALINA_HOME} \
	&& cd ${CATALINA_HOME} \
	&& curl -sSL https://mirrors.aliyun.com/apache/tomcat/tomcat-8/v8.5.59/bin/apache-tomcat-8.5.59.tar.gz -o tomcat.tar.gz \
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

WORKDIR ${CATALINA_HOME}
COPY server.xml conf/
COPY run.sh /usr/local/bin/

USER tomcat

CMD ["run.sh"]