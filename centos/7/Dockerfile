FROM centos:7

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && curl -o /etc/yum.repos.d/CentOS-Base.repo http://repo.huaweicloud.com/repository/conf/CentOS-7-reg.repo \
    && yum install -y tzdata epel-release \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && sed -i "s/#baseurl/baseurl/g" /etc/yum.repos.d/epel.repo \
    && sed -i "s/metalink/#metalink/g" /etc/yum.repos.d/epel.repo \
    && sed -i "s@https\?://download.fedoraproject.org/pub@https://repo.huaweicloud.com@g" /etc/yum.repos.d/epel.repo \
    && yum clean all