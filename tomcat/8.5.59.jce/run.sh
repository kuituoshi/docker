#!/bin/sh

: ${TOMCAT_PORT:=8080}
: ${TOMCAT_MEMORY:=1g}

JAVA_OPTS="${JAVA_OPTS} -Dhttp.port=${TOMCAT_PORT} -Xms${TOMCAT_MEMORY} -Xmx${TOMCAT_MEMORY}"

. catalina.sh run