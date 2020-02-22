FROM changel/python:3.6-buster

RUN set -ex \
	&& pip install urllib3 certifi datetime requests

COPY files /usr/local/bin/

RUN set -ex \
	&& chmod 775 /usr/local/bin/delExpiredImages.py

CMD ["delExpiredImages.py"]