FROM mysql:8.0

#base setup
RUN set -ex \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#config
COPY mysql.cnf /etc/mysql/conf.d/
