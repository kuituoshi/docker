# TOMCAT

* [`9-java.8`](https://github.com/kuituoshi/docker/blob/master/tomcat/9-java.8/Dockerfile)
* [`9-openj9.8`](https://github.com/kuituoshi/docker/blob/master/tomcat/9-openj9.8/Dockerfile)
* [`9-openjdk.8`](https://github.com/kuituoshi/docker/blob/master/tomcat/9-openjdk.8/Dockerfile)
* [`10-java.11`](https://github.com/kuituoshi/docker/blob/master/tomcat/10-java.11/Dockerfile)
* [`10-openj9.11`](https://github.com/kuituoshi/docker/blob/master/tomcat/10-openj9.11/Dockerfile)
* [`10-openjdk.11`](https://github.com/kuituoshi/docker/blob/master/tomcat/10-openjdk.11/Dockerfile)


## What is changed

* ENV TOMCAT_PORT: startup port, default is 8080
* ENV TOMCAT_MEMORY: java Xmx and Xms both set to 500m by default
* ENV TOMCAT_TZDATE: timezone setup to Asia/Shanghai by  default
* ENV JAVA_OPTS: default value "-server -Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF8 -Djava.security.egd=file:/dev/./urandom"
* ENV TOMCAT_PROFILE: if you set this to `dev`, then copy all files from `webapps/ROOT/WEB-INF/classes/profiles/dev` to `webapps/ROOT/WEB-INF/classes`

* ALL logs/INFO.log logs/DEBUG.log logs/WARN.log logs/ERROR.log files link to console output
* Put shell scripts in `/docker-entrypoint-init.d/` will be excuted before Start server