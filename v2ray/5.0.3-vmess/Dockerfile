FROM teddysun/v2ray:5.0.3


RUN set -ex \
	&& echo "https://mirrors.aliyun.com/alpine/v3.15/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.15/community" >>/etc/apk/repositories \
    && apk add --no-cache uuidgen nginx


COPY files /etc/nginx/

COPY config.json /etc/v2ray/

COPY run.sh /usr/local/bin/

CMD ["run.sh"]