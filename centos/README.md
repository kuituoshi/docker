# CentOS

* [`7`](https://github.com/kuituoshi/docker/blob/master/centos/7/Dockerfile)
* [`7-ssh`](https://github.com/kuituoshi/docker/blob/master/centos/7-ssh/Dockerfile)


## What is changed

* Setup locale to Shanghai of CHINA
* Setup mirrors to HuaweiCloud of CHINA
* Install Huawei epel

## 7-ssh

* Run sshd service by default
* Set ENV `SSHD_ROOT_PASSWORD` will change root password
* Put scripts in `/docker-entrypoint-init.d` will be executed before run sshd service