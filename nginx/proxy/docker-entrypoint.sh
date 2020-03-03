#!/bin/sh
set -eo pipefail

#initialize manage environments
: ${NGINX_PORT:=8080}
: ${NGINX_DNS:=8.8.8.8}
: ${NGINX_PROXY_PORTS:=80 443}
: ${NGINX_WHITE_LISTS:=all}


if [ "${1:0:1}" = '-' ]; then
	set -- nginx "$@"
fi



if [ "$1" = "nginx" ];then
	if [ "${NGINX_FILE:+x}" = "x" ];then
		set -- "$@" -c "${NGINX_FILE}"
	else
		NGINX_FILE=/usr/local/nginx/conf/nginx.conf
		NGINX_ACL=/usr/local/nginx/conf/acl.conf
		if [ ! -f ${NGINX_ACL} ];then
			sed -i "s/NGINX_PORT/${NGINX_PORT}/g" ${NGINX_FILE}
			sed -i "s/NGINX_DNS/${NGINX_DNS}/g" ${NGINX_FILE}
			sed -i "s/NGINX_PROXY_PORTS/${NGINX_PROXY_PORTS}/g" ${NGINX_FILE}
			for client in ${NGINX_WHITE_LISTS}
			do
				echo "allow $client;" >> ${NGINX_ACL}
			done
		fi
	fi
fi


exec "$@"