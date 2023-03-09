  #!/bin/sh
: ${NGINX_LISTEN_PORT:=8888}
: ${NGINX_DNS:=114.114.114.114}
: ${NGINX_ACCESS_CIDR:=0.0.0.0/0}


echo "启动参数"
echo "监听端口: ${NGINX_LISTEN_PORT}"
echo "DNS: ${NGINX_DNS}"
echo "IP白名单: ${NGINX_ACCESS_CIDR}"

sed -i "s/NGINX_DNS/${NGINX_DNS}/g" /etc/nginx/nginx.conf
sed -i "s/NGINX_LISTEN_PORT/${NGINX_LISTEN_PORT}/g" /etc/nginx/nginx.conf
sed -i "s#NGINX_ACCESS_CIDR#${NGINX_ACCESS_CIDR}#g" /etc/nginx/nginx.conf


nginx -g 'daemon off;'