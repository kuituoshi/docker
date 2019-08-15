#!/bin/sh
set -eo pipefail

#initialize manage environments
: ${SET_ETCD_FILE:=no}


if [ "${1:0:1}" = '-' ]; then
	set -- etcd "$@"
fi


if [ "${SET_ETCD_FILE}" == "no" -a "$1" == "etcd" ];then

	#default configuration
	: ${ETCD_NAME?is REQUIRED}
	: ${ETCD_DATA_DIR:=/var/lib/etcd}
	: ${ETCD_LISTEN_CLIENT_URLS:=http://0.0.0.0:2379}
	: ${ETCD_INITIAL_CLUSTER_TOKEN:=etcd-cluster}
	: ${ETCD_INITIAL_CLUSTER_STATE:=new}

	if [ "${ETCD_INITIAL_CLUSTER:+x}" = "x" ];then
		#如果设置了集群，则开启PEER监听，并检查是否映射了网络别名，如果没有则警告提示，如果手动设置为ip的PEER则忽视本条
		nslookup ${ETCD_NAME} 2>1 >/dev/null || echo "Warning ！！！ Make Sure ETCD_NAME aliase is set in your container network"
		: ${ETCD_LISTEN_PEER_URLS:=http://0.0.0.0:2380}
		: ${ETCD_INITIAL_ADVERTISE_PEER_URLS:=http://${ETCD_NAME}:2380}
		: ${ETCD_ADVERTISE_CLIENT_URLS:=http://${ETCD_NAME}:2379}
	else
		: ${ETCD_ADVERTISE_CLIENT_URLS:=http://localhost:2379}
	fi

	env_prefix="ETCD_"
	#do not use while ,because pipeline will start a subshell to execute
	for line in $(set | grep ^${env_prefix});
	do
		eval "export $line"
	done 
fi

exec "$@"