# TOMCAT

* [`8.5.59.jce`](https://github.com/kuituoshi/docker/blob/master/tomcat/8.5.59.jce/Dockerfile)
* [`8.5.23.jce`](https://github.com/kuituoshi/docker/blob/master/tomcat/8.5.23.jce/Dockerfile)
* [`7.0.88.jce`](https://github.com/kuituoshi/docker/blob/master/tomcat/7.0.88.jce/Dockerfile)


## What is changed

* Startup tomcat user is tomcat with id 1000 by default
* jce suffix is load unlimited JCE 
* Use TOMCAT_PORT env to setup tomcat http port, TOMCAT_MEMORY setup JAVA heap memory