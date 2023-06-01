FROM jenkins/jenkins:2.387.3-lts-alpine

MAINTAINER changel <changel@changel.cn>

#install git and svn and so on
USER root
RUN set -ex \
    && apk add --no-cache git openssh-client sshpass

#config jenkins
ENV JENKINS_HOME /var/lib/jenkins

USER jenkins