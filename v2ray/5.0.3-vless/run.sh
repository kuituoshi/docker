#!/bin/sh

: ${V2RAY_UUID:=x}
: ${V2RAY_DOMAIN:=ws.flyaway2oversea.com}
: ${V2RAY_PORT:=443}
: ${V2RAY_LOG_LEVEL:=warning}
: ${V2RAY_TIMEOUT:=600}
# 客户端暂未升级，强制禁用AEAD功能
: ${V2RAY_VMESS_AEAD_FORCED:=false}

UUID_FILE=/tmp/.uuidgen

if [ "${V2RAY_UUID}" == "x" -a -e ${UUID_FILE} ];then
	V2RAY_UUID=$(cat /tmp/.uuidgen)
elif [ "${V2RAY_UUID}" == "x" -a ! -e ${UUID_FILE} ];then
	V2RAY_UUID=$(uuidgen)
	echo "${V2RAY_UUID}" > ${UUID_FILE}
fi

echo "V2RAY: 启动参数信息"
echo "V2RAY: UUID -> ${V2RAY_UUID}"
echo "V2RAY: 端口 -> ${V2RAY_PORT}"
echo "V2RAY: 域名 -> ${V2RAY_DOMAIN}"
echo "V2RAY: 超时 -> ${V2RAY_TIMEOUT}秒"
echo "V2RAY: 日志级别 -> ${V2RAY_LOG_LEVEL}"
echo "V2RAY: AEAD -> ${V2RAY_VMESS_AEAD_FORCED}"

sed -i \
	-e "s/V2RAY_UUID/${V2RAY_UUID}/g" \
	-e "s/V2RAY_TIMEOUT/${V2RAY_TIMEOUT}/g" \
	-e "s/V2RAY_LOG_LEVEL/${V2RAY_LOG_LEVEL}/g" \
	-e "s/V2RAY_DOMAIN/${V2RAY_DOMAIN}/g" \
	-e "s/V2RAY_PORT/${V2RAY_PORT}/g" \
	/etc/v2ray/config.json

export V2RAY_VMESS_AEAD_FORCED

nginx
/usr/bin/v2ray run -config /etc/v2ray/config.json


