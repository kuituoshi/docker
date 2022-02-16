FROM changel/java:jre8.144.jce

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
	
WORKDIR ${SPRINGBOOT_HOME}
COPY run.sh /usr/local/bin/

CMD ["run.sh"]