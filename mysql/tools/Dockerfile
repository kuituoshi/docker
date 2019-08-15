FROM changel/ubuntu:18.04

#base setup
RUN set -ex \
	&& apt update \
	&& apt install -y percona-xtrabackup mysql-client\
	&& apt autoremove -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY my.cnf /etc/mysql/
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]