# SSPANEL

* [`3.0`](https://github.com/kuituoshi/docker/blob/master/sspanel/3.0/Dockerfile)
* [`node`](https://github.com/kuituoshi/docker/blob/master/sspanel/node/Dockerfile)

## What is changed

* Clone from `baiyuetribe/sspanel:master`

* Mount volume /sspanel, before start docker, cause sspanel source code will copy to /sspanel at first startup

## Ready to use sspanel

* Change `muKey` value in /sspanel/config/.config.php when you run in production environment

* Recover sql of `sql/glzjin_all.sql` in your database

* Change `db_host` `db_username` `db_password` values if you use your own database


```
php xcat createAdmin		#创建管理员账户
php xcat syncusers		#同步用户
php xcat initQQWry		#下载ip解析库
php xcat resetTraffic		#重置流量
php xcat initdownload		#下载客户端安装包


执行 crontab -e 命令, 添加以下四条（定时任务配置）：

30 22 * * * docker exec -t sspanel php xcat sendDiaryMail
0 0 * * * docker exec -t sspanel php -n xcat dailyjob
*/1 * * * * docker exec -t sspanel php xcat checkjob
*/1 * * * * docker exec -t sspanel php xcat syncnode
```

## How to use node

* support two mode which is `database` and `webapi`

* `NODE_ID` must be the same which is created in sspanel site

### Webapi Runtime environments

```
ENV NODE_ID     		
ENV WEBAPI_URL        	
ENV API_INTERFACE     	modwebapi
ENV WEBAPI_TOKEN        NimaQu
ENV DNS_1				8.8.8.8
ENV DNS_2				8.4.8.4
```

### database Runtime environments

```
ENV NODE_ID     		  	
ENV API_INTERFACE     	glzjinmod
ENV MYSQL_HOST        	mysql
ENV MYSQL_DATABSE		sspanel
ENV MYSQL_USER			root
ENV MYSQL_PASSWORD		sslpanel
ENV DNS_1				8.8.8.8
ENV DNS_2				8.4.8.4
```

