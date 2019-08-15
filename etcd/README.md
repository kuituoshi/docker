# ETCD

* [`3.3.13`](https://github.com/kuituoshi/docker/blob/master/etcd/3.3.13/Dockerfile)
* [`e3w`](https://github.com/kuituoshi/docker/blob/master/etcd/e3w/Dockerfile)



## What is changed

* e3w is a browser of etcd3, you use it before change default.ini configuration file

* setup `ETCD_INITIAL_CLUSTER` will startup cluster mode，if you don't standalone mode is ON

* if you want to use configuration file , setup `SET_ETCD_FILE=yes`

* `ETCD_NAME` is must required，this name should be setup the same as network aliases in container for connection with nodes

* Standalone mode should not set `ETCD_INITIAL_CLUSTER_STATE=existing` at first startup

* Once startup successfully , `INITIAL_*` parameters will not be checked for connection
