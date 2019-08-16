#!/bin/sh
set -e
php-fpm -D
service mysql start
nginx -g 'daemon off;'