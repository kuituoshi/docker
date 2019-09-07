# HTTPD

* [`2.4`, `latest`](https://github.com/kuituoshi/docker/blob/master/httpd/2.4/Dockerfile)


## What is changed

* Setup locale to Shanghai of CHINA
* Setup mirrors to ALIYUN of CHINA
* Default user is `www-data` with id `82`
* Enable `proxy ssl sendfile fastcgi wsgi cgi` by default
* Add two samples, access `/` with port 80 will browser `/usr/local/apache2/htdocs` path; access '/' with port 443 will proxy to `baidu.com and hao123.com`, sample file path is `conf/extra/httpd-vhosts.conf`, replace it 
* Prohibit .htaccess , indexes, symbolinks by default, be careful of using `AllowOverride All`, it will cause security problem
* Add Self-Signed-certification in conf/ssl directory , change this with Public Signed Certs in Production Server