FROM certbot/certbot:v2.4.0

#base setup
RUN set -ex \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#config
COPY run.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/run.sh"]

CMD ["certbot"]
