# OpenJDK

* [`8-slim`](https://github.com/kuituoshi/docker/blob/master/alphine/8-slim/Dockerfile)
* [`8-jre`](https://github.com/kuituoshi/docker/blob/master/openjdk/8-jre/Dockerfile)
* [`11-slim`](https://github.com/kuituoshi/docker/blob/master/openjdk/11-slim/Dockerfile)
* [`11-jre`](https://github.com/kuituoshi/docker/blob/master/openjdk/11-jre/Dockerfile)
* [`openj9-8-slim`](https://github.com/kuituoshi/docker/blob/master/alphine/openj9-8-slim/Dockerfile)
* [`openj9-8-jre`](https://github.com/kuituoshi/docker/blob/master/openjdk/openj9-8-jre/Dockerfile)
* [`openj9-11-slim`](https://github.com/kuituoshi/docker/blob/master/openjdk/openj9-11-slim/Dockerfile)
* [`openj9-11-jre`](https://github.com/kuituoshi/docker/blob/master/openjdk/openj9-11-jre/Dockerfile)

## What is changed

* Base image is adoptopenjdk/openjdk8:alpine
* Setup locale to Shanghai of CHINA
* Setup mirrors to ALIYUN of CHINA
* Have installed Maven, default command is `mvn` for jdk

## JRE

* Ca-certification installed


## SLIM

* extract unuseful tools and functions, Suppress image size