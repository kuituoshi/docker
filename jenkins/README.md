# JENKINS

* [`2.327`](https://github.com/kuituoshi/docker/blob/master/jenkins/2.327/Dockerfile)
* [`2.327-blue`](https://github.com/kuituoshi/docker/blob/master/jenkins/2.327-blue/Dockerfile)
* [`agent`](https://github.com/kuituoshi/docker/blob/master/jenkins/agent/Dockerfile)


## What is changed for Jenkins

* Jenkins use changel/tomcat:8.5.59 as base image, so run jenkins as tomcat user
* Install git svn openssh tools


## What is changed for JenkinsBlue

* Out of the box
* Preinstalled plugins `ansicolor ansible ant git blueocean Role-based Authorization Strategy`
* Default user and password `admin:123456`

## What is changed for JenkinsAgent

* Install git svn ssh-client ansible docker-client tools