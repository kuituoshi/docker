#!/bin/sh

: ${PROXY_SERVER_IP:?PROXY_SERVER_IP is required}
: ${PROXY_SERVER_PORT:?PROXY_SERVER_PORT is required}
: ${NGINX_LISTEN_PORT:=80}
: ${PROXY_SERVER_USER:?PROXY_SERVER_USER is required}
: ${PROXY_SERVER_PASSWORD:?PROXY_SERVER_PASSWORD is required}

PROXY_SERVER_AUTH=$(echo -n "${PROXY_SERVER_USER}:${PROXY_SERVER_PASSWORD}"|base64)

echo "启动参数"
echo "监听端口: ${NGINX_LISTEN_PORT}"
echo "代理IP: ${PROXY_SERVER_IP}"
echo "代理端口: ${PROXY_SERVER_PORT}"
echo "代理凭证: ${PROXY_SERVER_AUTH}"


sed -i "s/PROXY_SERVER_IP/${PROXY_SERVER_IP}/g" /etc/nginx/nginx.conf
sed -i "s/PROXY_SERVER_PORT/${PROXY_SERVER_PORT}/g" /etc/nginx/nginx.conf
sed -i "s/NGINX_LISTEN_PORT/${NGINX_LISTEN_PORT}/g" /etc/nginx/nginx.conf
sed -i "s/PROXY_SERVER_AUTH/${PROXY_SERVER_AUTH}/g" /etc/nginx/nginx.conf

nginx -g 'daemon off;'