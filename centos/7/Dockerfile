FROM centos:7

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && curl -o /etc/yum.repos.d/CentOS-Base.repo http://repo.huaweicloud.com/repository/conf/CentOS-7-reg.repo \
    && yum install -y tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum clean all