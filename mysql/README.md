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