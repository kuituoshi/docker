FROM php:7.1-fpm-alpine

#base setup
RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.10/main" >/etc/apk/repositories \
    && echo https://mirrors.aliyun.com/alpine/v3.10/main >>/etc/apk/repositories \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apk add --no-cache libtool curl curl-dev freetype libpng libjpeg-turbo freetype-dev libpng-dev \
    libjpeg-turbo-dev libxml2-dev gettext-dev openldap-dev \
    && docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NPROC} bcmath calendar ctype curl gd  pdo pdo_mysql bcmath xml sockets gettext json ldap mbstring mysqli  zip \
    && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

RUN set -ex \
    && apk add --no-cache nginx \
    && echo "Hello World" > /var/www/html/index.html

COPY nginx.conf /etc/nginx/
COPY zz-docker.conf /usr/local/etc/php-fpm.d/
COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 8080

CMD ["docker-entrypoint.sh"]