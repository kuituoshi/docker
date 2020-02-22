FROM changel/tomcat:8.5.34.jce

MAINTAINER changel <changel@changel.cn>

USER root

#config jenkins 
ENV JENKINS_HOME /var/lib/jenkins
ENV JENKINS_VER 2.204.2
WORKDIR ${CATALINA_HOME}
RUN set -ex \
    && apk add --no-cache curl \
    && curl -L https://www.changel.cn/repo/jenkins/${JENKINS_VER}/jenkins.war -o jenkins.war \
    && mkdir -p webapps/ROOT \
    && unzip jenkins.war -d webapps/ROOT \
    && rm -f jenkins.war \
    && apk del curl

ENV DOCKER_CLIENT_VERSION 18.06.1-ce
RUN set -ex \
    && apk add --no-cache curl \
    && curl -sSL -o /tmp/docker.tar.gz https://www.changel.cn/repo/docker/docker-linux-${DOCKER_CLIENT_VERSION}.tar.gz \
    && tar zxvf /tmp/docker.tar.gz -C /usr/bin/ \
    && mkdir /root/.docker \
    && rm -f /tmp/docker.tar.gz \
    && apk del curl

#install git and svn and so on
RUN set -ex \
    && apk add --no-cache ansible git subversion openssh-client python sshpass
    
USER tomcat