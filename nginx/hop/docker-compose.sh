#!/bin/sh

: ${PROXY_SERVER_IP:?PROXY_SERVER_IP is required}
: ${PROXY_SERVER_PORT:?PROXY_SERVER_PORT is required}
: ${NGINX_LISTEN_PORT:=443}
: ${NGINX_ACCESS_CIDR:=0.0.0.0/0}


echo "启动参数"
echo "监听端口: ${NGINX_LISTEN_PORT}"
echo "代理IP: ${PROXY_SERVER_IP}"
echo "代理端口: ${PROXY_SERVER_PORT}"
echo "IP白名单: ${NGINX_ACCESS_CIDR}"

sed -i "s/PROXY_SERVER_IP/${PROXY_SERVER_IP}/g" /etc/nginx/nginx.conf
sed -i "s/PROXY_SERVER_PORT/${PROXY_SERVER_PORT}/g" /etc/nginx/nginx.conf
sed -i "s/NGINX_LISTEN_PORT/${NGINX_LISTEN_PORT}/g" /etc/nginx/nginx.conf
sed -i "s#NGINX_ACCESS_CIDR#${NGINX_ACCESS_CIDR}#g" /etc/nginx/nginx.conf


nginx -g 'daemon off;'