# NGINX

* [`1.15`](https://github.com/kuituoshi/docker/blob/master/nginx/1.15/Dockerfile)
* [`1.16-header`](https://github.com/kuituoshi/docker/blob/master/nginx/1.16-header/Dockerfile)
* [`confd`](https://github.com/kuituoshi/docker/blob/master/nginx/confd/Dockerfile)
* [`proxy`](https://github.com/kuituoshi/docker/blob/master/nginx/proxy/Dockerfile)

## What is changed

*1.15*

* Copy from official image
* Set accelerating repository to `aliyun` and set timezone to `Asia/Shanghai`

*1.16-header*

* add more-header module
* but this image is installed from alpine repository

*confd*

* read confd [`README.md`](https://github.com/kuituoshi/docker/blob/master/nginx/confd/README.md)


*proxy*

* http proxy, use nginx version 1.14

* Set `NGINX_FILE` variable will use you own nginx configurations

* if no `NGINX_FILE` be set , `NGINX_PORT` `NGINX_PROXY_PORTS` `NGINX_DNS` can be use to set nginx `listen`,`proxy ports`, `dns resolver` directives

* Default value: NGINX_PORT=8080, NGINX_PROXY_PORTS=80 443, NGINX_DNS=8.8.8.8, NGINX_WHITE_LISTS=all

* For security , set `NGINX_WHITE_LISTS` will only allow client in this lists to connect your proxy