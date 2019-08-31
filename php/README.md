# PHP


* [`7.1`](https://github.com/kuituoshi/docker/blob/master/php/7.1/Dockerfile)
* [`5.6.36`](https://github.com/kuituoshi/docker/blob/master/php/5.6.36/Dockerfile)



## What is changed

* changel locale to Shanghai of CHINA, use ALIYUN mirror for pip
* expose 8080 for access nginx server which proxy php-fpm
* add `gd  mysql pdo pdo_mysql bcmath xml sockets gettext json ldap mbstring mysqli` php extentions
* default data path is `/var/www/html`