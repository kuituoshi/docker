FROM changel/php:7.1

#base setup
RUN set -ex \
    && mkdir -p /var/log/php-fpm \
    && ln -sf /dev/stdout /var/log/php-fpm/www-slow.log \
    && ln -sf /dev/stderr /var/log/php-fpm/www-error.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && ln -sf /dev/stdout /var/log/nginx/access.log

COPY nginx.conf /etc/nginx/
COPY zz-docker.conf /usr/local/etc/php-fpm.d/
COPY docker-entrypoint.sh /usr/local/bin/