FROM changel/python:3.7

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && apk add --no-cache uwsgi-python3 \
    && mkdir -p /var/www/html

# set default configuration
ENV PYTHONPATH=/usr/local/lib/python3.7/site-packages:/usr/lib/python3.7/site-packages
ENV UWSGI_HTTP_SOCKET=":9090" \
	UWSGI_UID=uwsgi \
	UWSGI_GID=uwsgi \
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