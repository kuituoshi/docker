#!/bin/sh
set -e
chown -R nexus ${SONATYPE_WORK}
cd ${NEXUS_HOME}
exec su-exec nexus java -Dnexus-work=${SONATYPE_WORK} -Dnexus-webapp-context-path=/nexus -Xms${MIN_HEAP} -Xmx${MAX_HEAP} -cp 'conf/:lib/*' -server -Djava.net.preferIPv4Stack=true org.sonatype.nexus.bootstrap.Launcher ./conf/jetty.xml ./conf/jetty-requestlog.xml