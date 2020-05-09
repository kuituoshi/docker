# MYSQL

* [`5.7`](https://github.com/kuituoshi/docker/blob/master/mysql/5.7/Dockerfile)
* [`5.5`](https://github.com/kuituoshi/docker/blob/master/mysql/5.5/Dockerfile)


## What is changed

* my.cnf is maken automatically in STANDALONE or CLUSTER mode, use env `MYSQLD_` preffix to setup your configuration file

* if you set `SET_MYSQLD_MASTER` in master node , you have to use `masterdb` aliases for slave to connect to master node

* `SET_MYSQLD_SLAVE` will become to SLAVE, `read_only` will be set to `1`, you have to setup `SET_MYSQLD_REPL_PASSWORD` the same with master node

* if you don't setup `SET_MYSQLD_REPL_PASSWORD`, the default value is `repl`, only work in initial stage

* default path for binlog or relay log are ${data}/mysql-binlog ${data}/mysql-relaylog

* Open GTID mode in 5.7 by default, if you don't want this , close it using `MYSQLD_GTID_MODE=OFF`

* Semi replication mode is open by default

* if set `SET_MYSQLD_PULL_PASSWORD` in SLAVE node , slave will pull all data at startup, if you want to add new slave , this is a good option


# INNOBACKUPEX

* [`tools`](https://github.com/kuituoshi/docker/blob/master/mysql/tools/Dockerfile)

## What is changed

* backup.sh is auto backup script, if you want use innobackupex to backup your data, change env in script header
* `--full`,`--incre`,`--restore` three parameters for backup.sh , It's eazy to use


# BACKUP

* [`archive`](https://github.com/kuituoshi/docker/blob/master/mysql/archive/Dockerfile)


## What is it

* Use mysqldump backup database
* Three backup Mode to choose
	* `time` add time suffix to database name in destination server
	* `same` same name to restore in destination server
	* `define` define the database name in destination server
	* `prefix` prefix the database name in destination server and append time

* If `BACKUP_DATABASE_FORCE=True`, will cover database in destination even database exists!

* Setup environments in your docker container to run backup Runner
	* `BACKUP_SOURCE_URL`  needed
	* `BACKUP_SOURCE_PORT` default is `3306`
	* `BACKUP_SOURCE_USER` default is `root`
	* `BACKUP_SOURCE_PASS` needed
	* `BACKUP_DEST_URL`    needed
	* `BACKUP_DEST_PORT`   default is `3306`
	* `BACKUP_DEST_USER`   default is `root`
	* `BACKUP_DEST_PASS`   needed

	* `BACKUP_DATABASE`    needed
	* `BACKUP_DATABASE_FORCE`    default is `False`
	* `BACKUP_MODE`        default is `time`
	* `BACKUP_DEFINE_NAME` needed if `BACKUP_MODE=define`
	* `BACKUP_PREFIX_NAME` needed if `BACKUP_MODE=prefix`

* Run extra sql file in destination DATABASE, Just put .sql or .sql.gz into `/docker-entrypoint-initdb.d` directory
