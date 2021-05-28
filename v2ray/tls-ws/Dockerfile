FROM v2ray/official


RUN set -ex \
	&& echo "https://mirrors.aliyun.com/alpine/v3.11/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.11/community" >>/etc/apk/repositories \
    && mkdir -p /var/log/nginx /etc/nginx/certs \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
	&& apk add --no-cache nginx openssl supervisor

COPY config.json /etc/v2ray/
COPY nginx.conf /etc/nginx/
COPY docker-compose.sh /usr/local/bin/
COPY supervisord.conf /etc/

EXPOSE 4443

CMD ["docker-compose.sh"]