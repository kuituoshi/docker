# PYTHONE

* [`3.6-uwsgi`](https://github.com/kuituoshi/docker/blob/master/python/3.6-uwsgi/Dockerfile)
* [`3.6`](https://github.com/kuituoshi/docker/blob/master/python/3.6/Dockerfile)
* [`2.7`](https://github.com/kuituoshi/docker/blob/master/python/2.7/Dockerfile)


## What is changed

* changel locale to Shanghai of CHINA, use ALIYUN mirror for pip
* if you use uwsgi, you should set main procedure name to  `main.py` and ingress to `app`
* setup `UWSGI_CALLABLE`,`UWSGI_WSGI_FILE` to change callable file and app
* put your application file to `UWSGI_CHDIR=/var/www/html` by default, change this if you want
* map 9090 to internet