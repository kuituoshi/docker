FROM mysql:8.3

#base setup
RUN set -ex \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#config
COPY make-config.sh /usr/local/bin/

ENTRYPOINT ["make-config.sh"]

CMD ["mysqld"]
