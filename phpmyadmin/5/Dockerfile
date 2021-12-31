FROM phpmyadmin:5

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && echo 'deb http://mirrors.aliyun.com/debian/ buster main non-free contrib' > /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.aliyun.com/debian-security buster/updates main' >> /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian-security buster/updates main' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib' >> /etc/apt/sources.list

COPY config.user.inc.php /etc/phpmyadmin/