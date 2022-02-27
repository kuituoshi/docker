# UWSGI


* [`3.7`](https://github.com/kuituoshi/docker/blob/master/uwsgi/3.7/Dockerfile)
* [`3.6`](https://github.com/kuituoshi/docker/blob/master/uwsgi/3.6/Dockerfile)
* [`3.7-alpine`](https://github.com/kuituoshi/docker/blob/master/uwsgi/3.7-alpine/Dockerfile)
* [`3.6-alpine`](https://github.com/kuituoshi/docker/blob/master/uwsgi/3.6-alpine/Dockerfile)
* [`3.7-bullseye`](https://github.com/kuituoshi/docker/blob/master/uwsgi/3.7-bullseye/Dockerfile)
* [`3.7-tdlib-1.8.0`](https://github.com/kuituoshi/docker/blob/master/uwsgi/3.7-tdlib-1.8.0/Dockerfile)



## What is changed

* changel locale to Shanghai of CHINA, use ALIYUN mirror for pip
* if you use uwsgi, you should set main procedure name to  `main.py` and ingress to `app`
* setup `UWSGI_CALLABLE`,`UWSGI_WSGI_FILE` to change callable file and app
* put your application file to `UWSGI_CHDIR=/var/www/html` by default, change this if you want
* map 9090 to internet