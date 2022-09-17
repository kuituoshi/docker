FROM centos:7

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo \
    && yum install -y tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum clean all