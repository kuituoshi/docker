#!/bin/sh
set -eo pipefail

#initialize manage environments
: ${SET_NGINX_FILE:-/etc/nginx/nginx.conf}
: ${SET_CONFD_FILE:-/etc/confd/confd.toml}
: ${SET_CONFD_ENABLE:=no}
: ${SET_ETCD_NODES:-127.0.0.1:2379}


if [ "${1:0:1}" = '-' ]; then
	set -- nginx "$@"
fi

if [ "${SET_NGINX_FILE:+x}" = "x" ];then
	set -- "$@" -c "${SET_NGINX_FILE}"
fi

if [ "${SET_CONFD_ENABLE}" = "yes" -a "$1" = "nginx" ];then
	#must set etcd_nodes env or confd configuration file
	if [ "${SET_ETCD_NODES:-x}" = "x" -a "${SET_CONFD_FILE:-x}" = "x" ];then
		echo "Error ! After you enable confd service, you must set env SET_ETCD_NODES or SET_CONFD_FILE"
		exit 1
	fi

	if [ "${SET_CONFD_FILE:+x}" = "x" ];then
		until confd -onetime -config-file ${SET_CONFD_FILE}; do
			echo "[confd service]: using file SET_CONFD_FILE: ${SET_ETCD_NODES} ..."
			echo "[confd service]: making configuration file ..."
			sleep 10
		done
		confd -config-file ${SET_CONFD_FILE} &
	else
		until confd -onetime -node ${SET_ETCD_NODES}; do
			echo "[confd service]: using environment SET_ETCD_NODES: ${SET_ETCD_NODES} ..."
			echo "[confd service]: making configuration file ..."
			sleep 10
		done
		confd -node ${SET_ETCD_NODES} &
	fi
	
	echo "[confd service]: confd is listening for changes on etcd ..."
	echo "[nginx service]: starting nginx service ..."
fi



exec "$@"