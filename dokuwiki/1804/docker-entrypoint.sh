#!/bin/sh

set -e

PHP_DIR="/var/www/html"
WIKI_VERSION=1804
WIKI_URL="https://www.changel.cn/repo/dokuwiki"


if [ "`ls -A ${PHP_DIR}`" = "" ];then
		echo "Downloading package..., wait for a moment"
		cd ${PHP_DIR}
        curl -sSL -o ${WIKI_VERSION}.tgz ${WIKI_URL}/${WIKI_VERSION}.tgz
        tar zxf ${WIKI_VERSION}.tgz --strip-components 1 -C .
        rm -f ${WIKI_VERSION}.tgz
        chown -R root:root *
        chown -R www-data:root conf data lib/tpl lib/plugins
        echo "Download Completely, startup Server"
fi

php-fpm -D
nginx -g 'daemon off;'