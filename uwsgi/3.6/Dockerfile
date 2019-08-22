FROM changel/python:3.6-buster

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && apt update \
    && apt install -y gcc \
    && pip install --no-cache-dir uwsgi \
    && mkdir -p /var/www/html \
    && apt-get remove --purge --auto-remove -y gcc \
    && rm -rf /var/lib/apt/lists /var/tmp/* /tmp/*

# set default configuration
ENV PYTHONPATH=/usr/local/lib/python3.6/site-packages:/usr/lib/python3.6/site-packages
ENV UWSGI_HTTP_SOCKET=":9090" \
	UWSGI_UID=www-data \
	UWSGI_GID=www-data \
	UWSGI_PLUGIN=python3 \
	UWSGI_PROCESSES=2 \
	UWSGI_THREADS=3 \
	UWSGI_MASTER=1 \
	UWSGI_ENABLE_THREADS=true \
	UWSGI_CHDIR=/var/www/html \
	UWSGI_WSGI_FILE=main.py \
	UWSGI_CALLABLE=app

EXPOSE 9090

CMD ["uwsgi"]