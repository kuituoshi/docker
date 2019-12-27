# DOKUWIKI


* [`1804`](https://github.com/kuituoshi/docker/blob/master/dokuwiki/1804/Dockerfile)
* [`1804-box`](https://github.com/kuituoshi/docker/blob/master/dokuwiki/1804-box/Dockerfile)


## What is changed in 1804

* Mount `/var/www/html`, all dokuwiki file will be downloaded into it, if any file exist, Download will be skipped!
* Expose 80 access port, limit access secrity directory (bin,conf,data,inc,lib,vendor)
* Only allowed to write directory of (data,conf,lib/tpl,lib/plugins),Change this if you want
* Output nginx log and php log to docker console


## What is changed in 1804-box

* Mount `/var/www/html`, all dokuwiki file will be downloaded into it, if any file exist, Download will be skipped!
* Expose 80 access port, limit access secrity directory (bin,conf,data)
* Only allowed to write directory of (data,conf,lib/tpl,lib/plugins),Change this if you want, for security only keep language `en` and `zh`
* Output nginx log and php log to docker console
* Default login user is `admin` password: `123456`
* Installed plugin: `bootstamp3`,`markdownku`,`PDF exporter`