#!/bin/sh

process_init_file() {
	local f="$1";

	case "$f" in
		*.sh)     echo "TOMCAT BOOTING: Running  initial script $f"; . "$f" ;;
		*)        echo "TOMCAT BOOTING: Ignoring $f" ;;
	esac
}

: ${TOMCAT_PORT:=8080}
: ${TOMCAT_MEMORY:=500m}
: ${TOMCAT_PROFILE:-dev}
: ${TOMCAT_TZDATE:-Asia/Shanghai}

: ${JAVA_OPTS:=-server -Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF8 -Djava.security.egd=file:/dev/./urandom}
: ${JAVA_OPTS_EXTRA:-}
: ${CATALINA_OUT:=/dev/null}

#JMX Configuration
: ${JMX_EXPORTER_ENABLE:=no}
: ${JMX_EXPORTER_PORT:=8088}
: ${JMX_EXPORTER_USERNAME:=jmx_exporter}
: ${JMX_EXPORTER_PASSWORD:=jmx_exporter}


TOMCAT_CLASSES=${CATALINA_HOME}/webapps/ROOT/WEB-INF/classes

# Copy profile to classes path, override configuration or applicationContext files
if [ "${TOMCAT_PROFILE:+x}" = "x" -a -d ${TOMCAT_CLASSES}/profiles/${TOMCAT_PROFILE} ];then
	echo "TOMCAT BOOTING: Found TOMCAT_PROFILE: ${TOMCAT_PROFILE}, Override configurations"
	cp -r ${TOMCAT_CLASSES}/profiles/${TOMCAT_PROFILE}/* ${TOMCAT_CLASSES}/
fi

if [ "${TOMCAT_TZDATE:+x}" = "x" ];then
	echo "TOMCAT BOOTING: Found TOMCAT_TZDATE: ${TOMCAT_TZDATE}, Setup timezone"
	ln -sf /usr/share/zoneinfo/${TOMCAT_TZDATE} /etc/localtime
fi

if [ "${JMX_EXPORTER_ENABLE}" == "yes" ];then
     echo "username: ${JMX_EXPORTER_USERNAME}" >>${JAVA_HOME}/lib/jmx/jmx_prometheus.yaml
     echo "password: ${JMX_EXPORTER_PASSWORD}" >>${JAVA_HOME}/lib/jmx/jmx_prometheus.yaml
     JAVA_OPTS="${JAVA_OPTS} -javaagent:${JAVA_HOME}/lib/jmx/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar=${JMX_EXPORTER_PORT}:${JAVA_HOME}/lib/jmx/jmx_prometheus.yaml"
fi

export JAVA_OPTS="-Dhttp.port=${TOMCAT_PORT} -Xms${TOMCAT_MEMORY} -Xmx${TOMCAT_MEMORY} ${JAVA_OPTS} ${JAVA_OPTS_EXTRA}"
export CATALINA_OUT=${CATALINA_OUT}

# Run scripts in docker-entrypoint-init.d
for f in /docker-entrypoint-init.d/*; do
	process_init_file "$f"
done

echo "TOMCAT BOOTING: Run as port: ${TOMCAT_PORT}"

exec su-exec tomcat catalina.sh run