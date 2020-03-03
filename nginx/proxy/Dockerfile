FROM changel/alpine:3.10

RUN set -ex \
	&& wget http://nginx.org/download/nginx-1.14.2.tar.gz \
	&& tar -xzvf nginx-1.14.2.tar.gz \
	&& cd nginx-1.14.2/ \
	&& wget https://codeload.github.com/chobits/ngx_http_proxy_connect_module/tar.gz/v0.0.1 -O ngx_http_proxy_connect_module.tar.gz \
	&& tar -xzvf ngx_http_proxy_connect_module.tar.gz \
	&& patch -p1 < ngx_http_proxy_connect_module-0.0.1/patch/proxy_connect_1014.patch \
        && apk add --no-cache pcre \
	&& apk add --no-cache --virtual .build-deps \
                gcc \
                libc-dev \
                make \
                openssl-dev \
                pcre-dev \
                zlib-dev \
                libxslt-dev \
                gd-dev \
                geoip-dev \
	&& ./configure --add-module=ngx_http_proxy_connect_module-0.0.1 \
	&& make \
	&& make install \
	&& apk del .build-deps \
        && rm -rf nginx-1.14.2.tar.gz nginx-1.14.2 \
        && addgroup -g 101 -S nginx \
        && adduser -S -D -H -u 101 -s /sbin/nologin -G nginx -g nginx nginx \
	&& ln -sf /usr/local/nginx/sbin/nginx /usr/bin/nginx \
        && mkdir -p /var/log/nginx \
        && ln -sf /dev/stderr /var/log/nginx/error.log \
        && ln -sf /dev/stdout /var/log/nginx/access.log

COPY docker-entrypoint.sh /usr/local/bin/
COPY files /usr/local/nginx/conf/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]