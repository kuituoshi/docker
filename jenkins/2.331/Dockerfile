FROM changel/tomcat:10-openj9.11

MAINTAINER changel <changel@changel.cn>

#install git and svn and so on
RUN set -ex \
    && apk add --no-cache git subversion openssh-client sshpass

#config jenkins
ENV JENKINS_HOME /var/lib/jenkins
ENV JENKINS_VER 2.403
ENV TOMCAT_MEMORY 1g
WORKDIR ${CATALINA_HOME}
RUN set -ex \
    && apk add --no-cache curl \
    && curl -L https://mirrors.aliyun.com/jenkins/war/${JENKINS_VER}/jenkins.war -o jenkins.war \
    && mkdir -p ${JENKINS_HOME}\
    && unzip jenkins.war -d webapps/ROOT \
    && rm -f jenkins.war \
    && apk del curl

RUN set -ex \
	&& apk add --no-cache ttf-dejavu