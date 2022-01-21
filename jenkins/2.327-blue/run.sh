#!/bin/sh

: ${TOMCAT_PORT:=8080}
: ${TOMCAT_MEMORY:=1g}

JAVA_OPTS="${JAVA_OPTS} -Dfile.encoding=UTF-8 -Dhttp.port=${TOMCAT_PORT} -Xms${TOMCAT_MEMORY} -Xmx${TOMCAT_MEMORY}"

if [ "`ls -A ${JENKINS_HOME}`" = "" ];then
		echo "extract package..., wait for a moment"
		unzip /jenkins.zip -d ${JENKINS_HOME}
        echo "Completely, startup Server"
fi

chown -R tomcat ${JENKINS_HOME}
exec su-exec tomcat ${CATALINA_HOME}/bin/catalina.sh run