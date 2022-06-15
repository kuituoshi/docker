FROM mysql:5.7.27

#base setup
RUN set -ex \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#config
COPY make-config.sh /usr/local/bin/

ENTRYPOINT ["make-config.sh"]
VOLUME /var/run/mysqld

CMD ["mysqld"]