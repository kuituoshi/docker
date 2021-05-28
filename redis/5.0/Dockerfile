FROM redis:5.0-alpine

MAINTAINER changel <changel@changel.cn>

# install timezone
RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.13/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.13/community" >>/etc/apk/repositories \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV SET_REDIS_DAEMONIZE=no \
	SET_REDIS_BIND=0.0.0.0 \
	SET_REDIS_PROTECTED_MODE=yes \
	#change this ,you should change workdir too.
	SET_REDIS_DIR=/data

ADD auto-config.sh /usr/local/bin/

CMD ["auto-config.sh"]