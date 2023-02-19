#!/bin/sh

: ${FRP_PORT:=7000}
: ${FRP_TOKEN:?FRP_TOKEN is required}

echo "FRP: 启动参数信息"
echo "FRP: 端口 -> ${FRP_PORT}"
echo "FRP: TOKEN -> ${FRP_TOKEN}"

sed -i \
	-e "s/FRP_TOKEN/${FRP_TOKEN}/g" \
	-e "s/FRP_PORT/${FRP_PORT}/g" \
	/etc/frp/frps.ini


/usr/bin/frps -c /etc/frp/frps.ini


