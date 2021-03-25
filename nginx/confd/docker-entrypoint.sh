#!/bin/sh
set -eo pipefail

#initialize manage environments
: ${SET_CONFD_NODE:=127.0.0.1:2379/0}
: ${SET_CONFD_NODE_PASSWORD:=x}
: ${SET_CONFD_INTERVAL:=30}
: ${SET_CONFD_PREFIX:=/nginx}


if [ "${1:0:1}" = '-' ]; then
	set -- nginx "$@"
fi

if [ "${SET_NGINX_FILE:+x}" = "x" ];then
	set -- "$@" -c "${SET_NGINX_FILE}"
fi


if [ "$1" = "nginx" ];then
	
	until confd -onetime -backend redis -client-key ${SET_CONFD_NODE_PASSWORD} -node ${SET_CONFD_NODE}; do
		echo "[confd service]: making configuration file ..."
		sleep 10
	done
	if [ "${SET_CONFD_INTERVAL}" = "0" ];then
		confd -backend redis -prefix ${SET_CONFD_PREFIX} -client-key ${SET_CONFD_NODE_PASSWORD} -node ${SET_CONFD_NODE} -watch &
	else
		confd -backend redis -prefix ${SET_CONFD_PREFIX} -client-key ${SET_CONFD_NODE_PASSWORD} -node ${SET_CONFD_NODE} -interval ${SET_CONFD_INTERVAL} &
	fi
	
	echo "[nginx service]: Making successfully, Starting nginx service ..."
	echo "[confd service]: confd prefix -> ${SET_CONFD_PREFIX}"
	if [ "${SET_CONFD_NODE_PASSWORD}" != "x" ];then
		echo "[confd service]: confd password -> ${SET_CONFD_NODE_PASSWORD}"
	fi
	echo "[confd service]: confd node -> ${SET_CONFD_NODE}"
	echo "[confd service]: confd is listening for changes on redis ..."
fi


exec "$@"