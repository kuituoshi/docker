FROM changel/httpd:2.4

RUN set -ex \
	&& apk add --no-cache subversion mod_dav_svn

RUN set -ex \
	&& apk add --no-cache su-exec \
	&& mkdir -p /var/lib/svn \
	&& echo "Include conf/extra/httpd-svn.conf" >> conf/httpd.conf \
	&& sed -i \
		-e 's/^#\(LoadModule .*mod_dav.so\)/\1/' \
        -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
        -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
        -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
        conf/httpd.conf \
    && ssl_log_line=$(grep -nw "^CustomLog" conf/extra/httpd-ssl.conf |awk -F : '{printf $1}') \
    && sed -i "${ssl_log_line},$((${ssl_log_line}+1)) d" conf/extra/httpd-ssl.conf

WORKDIR /var/lib/svn

COPY ssl /usr/local/apache2/conf/

COPY httpd-svn.conf /usr/local/apache2/conf/extra/

COPY run.sh /usr/local/bin/

EXPOSE 443

CMD ["run.sh"]