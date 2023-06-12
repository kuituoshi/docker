#!/bin/sh
set -eo pipefail

#initialize manage environments
: ${NGINX_PORT:=50001}
: ${NGINX_WHITE_LISTS:=all}
: ${NGINX_USER:=repoadmin}
: ${NGINX_PASSWORD:?NGINX_PASSWORD is missing}

echo "启动参数"
echo "监听端口: ${NGINX_PORT}"
echo "访问用户: ${NGINX_USER}"
echo "访问密码: ${NGINX_PASSWORD}"
echo "IP白名单: ${NGINX_WHITE_LISTS}"

NGINX_FILE=/etc/nginx/nginx.conf
NGINX_ACL=/etc/nginx/acl.conf
NGINX_AUTH=/etc/nginx/access.pass
if [ ! -f ${NGINX_ACL} ];then
  sed -i "s/NGINX_PORT/${NGINX_PORT}/g" ${NGINX_FILE}
  htpasswd -b -c ${NGINX_AUTH} ${NGINX_USER} ${NGINX_PASSWORD}
  for client in ${NGINX_WHITE_LISTS}
  do
    echo "allow $client;" >> ${NGINX_ACL}
  done
fi

nginx -g 'daemon off;'