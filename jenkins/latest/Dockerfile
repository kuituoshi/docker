FROM changel/tomcat:8.5.59.jce

MAINTAINER changel <changel@changel.cn>

USER root

#config jenkins
ENV JENKINS_HOME /var/lib/jenkins
ENV JENKINS_VER latest
WORKDIR ${CATALINA_HOME}
RUN set -ex \
    && apk add --no-cache curl \
    && curl -L https://mirrors.aliyun.com/jenkins/war/${JENKINS_VER}/jenkins.war -o jenkins.war \
    && mkdir -p webapps/ROOT \
    && unzip jenkins.war -d webapps/ROOT \
    && rm -f jenkins.war \
    && apk del curl


#install git and svn and so on
RUN set -ex \
    && apk add --no-cache git subversion openssh-client sshpass
    
USER tomcat