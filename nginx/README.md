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

* confd is open by default

* if set `SET_NGINX_FILE` variable which means you want to use your own nginx file

* you must set `SET_CONFD_FILE`(high priority) or `SET_ETCD_NODES` to connect to etcd SERVER

* root keys directory is `/services/nginx/` if you want to set upstream server, put keys in `/services/nginx/stream/upstream/server/*`; set listen value in `/services/nginx/stream/server/listen`, and so on

* etcd auth should set in files

* monitor `/services/nginx/` prefix, if anything changes nginx will reload


*proxy*

* http proxy, use nginx version 1.14

* Set `NGINX_FILE` variable will use you own nginx configurations

* if no `NGINX_FILE` be set , `NGINX_PORT` `NGINX_PROXY_PORTS` `NGINX_DNS` can be use to set nginx `listen`,`proxy ports`, `dns resolver` directives

* Default value: NGINX_PORT=8080, NGINX_PROXY_PORTS=80 443, NGINX_DNS=8.8.8.8, NGINX_WHITE_LISTS=all

* For security , set `NGINX_WHITE_LISTS` will only allow client in this lists to connect your proxy