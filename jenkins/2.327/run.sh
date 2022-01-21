#!/bin/sh

: ${TOMCAT_PORT:=8080}
: ${TOMCAT_MEMORY:=1g}

JAVA_OPTS="${JAVA_OPTS} -Dfile.encoding=UTF-8 -Dhttp.port=${TOMCAT_PORT} -Xms${TOMCAT_MEMORY} -Xmx${TOMCAT_MEMORY}"

chown -R tomcat ${JENKINS_HOME}
exec su-exec tomcat ${CATALINA_HOME}/bin/catalina.sh run