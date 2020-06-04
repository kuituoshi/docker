#!/bin/sh

: ${V2RAY_UUID:?V2RAY_UUID is required}
: ${V2RAY_DOMAIN:?V2RAY_DOMAIN is required}
: ${V2RAY_PORT:=4443}

echo "启动参数"
echo "UUID: ${V2RAY_UUID}"
echo "端口: ${V2RAY_PORT}"
echo "域名: ${V2RAY_DOMAIN}"

sed -i "s/V2rayId/${V2RAY_UUID}/g" /etc/v2ray/config.json
sed -i "s/V2rayPort/${V2RAY_PORT}/g" /etc/nginx/nginx.conf

echo subjectAltName = DNS:${V2RAY_DOMAIN} > /tmp/extfile.cnf

openssl req -new -x509 -nodes -newkey rsa:2048 -keyout /etc/nginx/certs/server.key \
-out /etc/nginx/certs/server.crt \
-subj "/CN=${V2RAY_DOMAIN}" \
-days 10950 2>/dev/null

v2ray -config=/etc/v2ray/config.json &
nginx -g 'daemon off;'