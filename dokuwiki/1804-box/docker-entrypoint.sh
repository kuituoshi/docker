#!/bin/sh

set -e

PHP_DIR="/var/www/html"
WIKI_VERSION=1804-box
WIKI_URL="https://www.changel.cn/repo/dokuwiki"


if [ "`ls -A ${PHP_DIR}`" = "" ];then
		echo "Downloading package..., wait for a moment"
		cd ${PHP_DIR}
        curl -sSL -k -o ${WIKI_VERSION}.tar.gz ${WIKI_URL}/${WIKI_VERSION}.tar.gz
        tar zxf ${WIKI_VERSION}.tar.gz -C .
        rm -f ${WIKI_VERSION}.tar.gz
        chown -R root:root *
        chown -R www-data:root conf data lib/tpl lib/plugins
        echo "Download Completely, startup Server"
fi

php-fpm -D
nginx -g 'daemon off;'