# JENKINS

* [`latest`](https://github.com/kuituoshi/docker/blob/master/jenkins/latest/Dockerfile)
* [`agent`](https://github.com/kuituoshi/docker/blob/master/jenkins/agent/Dockerfile)


## What is changed

* Install git svn ssh-client ansible docker-client tools
* Jenkins use changel/tomcat:8.5.59 as base image, so run jenkins as tomcat user
* If you want to use port 80, you should change System User