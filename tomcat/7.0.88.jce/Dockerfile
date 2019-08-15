FROM changel/java:jre7.80.jce

MAINTAINER changel <changel@changel.cn> 

# install tomcat
ENV LANG="en_US.UTF-8" CATALINA_HOME="/usr/local/tomcat"
ENV PATH="${CATALINA_HOME}/bin:$PATH"
ENV JAVA_OPTS="-server -Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF8 -Xms512m -Xmx512m -XX:PermSize=112m -XX:MaxPermSize=212m -Djava.security.egd=file:/dev/./urandom"
RUN set -ex \
	&& apk add --no-cache curl \
	&& mkdir -p ${CATALINA_HOME} \
	&& cd ${CATALINA_HOME} \
	&& curl -sSL https://www.changel.cn/repo/tomcat/apache-tomcat-7.0.88.tar.gz -o tomcat.tar.gz \
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

USER tomcat

#expose and command
EXPOSE 8080
CMD ["catalina.sh", "run"]