FROM changel/nginx:1.15

MAINTAINER changel <changel@changel.cn>

#install confd
RUN set -ex \
	&& wget https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 -O /usr/local/bin/confd \
	&& chmod +x /usr/local/bin/confd \
	&& mkdir -p /etc/confd

COPY docker-entrypoint.sh /usr/local/bin/
COPY files /etc/confd/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]