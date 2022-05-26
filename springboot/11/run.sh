#!/bin/sh
process_init_file() {
     local f="$1";

     case "$f" in
          *.sh)     echo "SPRINGBOOT BOOTING: Running  initial script $f"; . "$f" ;;
          *)        echo "SPRINGBOOT BOOTING: Ignoring $f" ;;
     esac
}

#initialize manage environments
: ${SPRINGBOOT_PORT:=8080}
: ${SPRINGBOOT_MEMORY:=512m}
: ${SPRINGBOOT_JAR_NAME:=boot.jar}
: ${SPRINGBOOT_HOME:=/workdir}
: ${SPRINGBOOT_ACTIVE_PROFILE:-uat}
: ${SPRINGBOOT_PRINT_GC:=no}
: ${SPRINGBOOT_OPTS:-x}
: ${SPRINGBOOT_TZDATE:-Asia/Shanghai}

: ${JAVA_OPTS:=-Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF8 -Djava.security.egd=file:/dev/urandom}
: ${JAVA_OPTS_EXTRA:-}

if [ "${SPRINGBOOT_ACTIVE_PROFILE:+x}" = "x" ];then
	SPRINGBOOT_OPTS="${SPRINGBOOT_OPTS} --spring.profiles.active=${SPRINGBOOT_ACTIVE_PROFILE}"
fi

# must create /logs directory which java have write permission first
if [ "${SPRINGBOOT_PRINT_GC}" == "yes" ];then
     JAVA_OPTS="${JAVA_OPTS} -Xloggc:/logs/gc.log -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M"
fi

if [ "${SPRINGBOOT_TZDATE:+x}" = "x" ];then
	echo "SPRINGBOOT BOOTING: Found SPRINGBOOT_TZDATE: ${SPRINGBOOT_TZDATE}, Setup timezone"
	ln -sf /usr/share/zoneinfo/${SPRINGBOOT_TZDATE} /etc/localtime
fi

# Run scripts in docker-entrypoint-init.d
for f in /docker-entrypoint-init.d/*; do
     process_init_file "$f"
done

exec su-exec java \
     java -Xms${SPRINGBOOT_MEMORY} \
     -Xmx${SPRINGBOOT_MEMORY} \
     ${JAVA_OPTS} ${JAVA_OPTS_EXTRA}\
     -jar ${SPRINGBOOT_HOME}/${SPRINGBOOT_JAR_NAME} \
     ${SPRINGBOOT_OPTS} \
     --server.port=${SPRINGBOOT_PORT}
     