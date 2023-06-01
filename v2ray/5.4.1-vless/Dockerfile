FROM teddysun/v2ray:5.4.1


RUN set -ex \
	&& echo "https://mirrors.aliyun.com/alpine/v3.15/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.15/community" >>/etc/apk/repositories \
    && apk add --no-cache uuidgen nginx


COPY nginx/nginx.conf /etc/nginx/
COPY html /usr/share/nginx/

COPY files /etc/v2ray/

COPY run.sh /usr/local/bin/

CMD ["run.sh"]