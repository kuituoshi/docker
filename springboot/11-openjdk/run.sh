#!/bin/sh

#initialize manage environments
: ${SPRINGBOOT_PORT:=8080}
: ${SPRINGBOOT_MEMORY:=1g}
: ${SPRINGBOOT_JAR_NAME:=boot.jar}
: ${SPRINGBOOT_HOME:=/workdir}
: ${SPRINGBOOT_ACTIVE_PROFILE:-uat}

SPRINGBOOT_OPTS=""

if [ "${SPRINGBOOT_ACTIVE_PROFILE:+x}" = "x" ];then
	SPRINGBOOT_OPTS="${SPRINGBOOT_OPTS} --spring.profiles.active=${SPRINGBOOT_ACTIVE_PROFILE}"
fi
exec su-exec java \
     java -Xms${SPRINGBOOT_MEMORY} \
     -Xmx${SPRINGBOOT_MEMORY} \
     -Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF8 \
     -Djava.security.egd=file:/dev/./urandom \
     ${JAVA_OPTS} \
     -jar ${SPRINGBOOT_HOME}/${SPRINGBOOT_JAR_NAME} \
     ${SPRINGBOOT_OPTS} \
     --server.port=${SPRINGBOOT_PORT}
     