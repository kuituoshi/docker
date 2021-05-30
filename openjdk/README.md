# OpenJDK

* [`1.8`](https://github.com/kuituoshi/docker/blob/master/alphine/1.8/Dockerfile)
* [`1.8-slim`](https://github.com/kuituoshi/docker/blob/master/openjdk/1.8-slim/Dockerfile)
* [`1.8-jre`](https://github.com/kuituoshi/docker/blob/master/openjdk/1.8-jre/Dockerfile)
* [`11`](https://github.com/kuituoshi/docker/blob/master/alphine/11/Dockerfile)
* [`11-slim`](https://github.com/kuituoshi/docker/blob/master/openjdk/11-slim/Dockerfile)
* [`11-jre`](https://github.com/kuituoshi/docker/blob/master/openjdk/11-jre/Dockerfile)


## What is changed

* replace 3.13 fix network bugs
* Base image is adoptopenjdk/openjdk8:alpine
* Setup locale to Shanghai of CHINA
* Setup mirrors to ALIYUN of CHINA
* Have installed Maven, default command is `mvn` for jdk

## JRE

* Ca-certification installed


## SLIM

* extract unuseful tools and functions, Suppress image size