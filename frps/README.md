# FRP

* [`0.47.0`](https://github.com/kuituoshi/docker/blob/master/FRP/0.47.0/Dockerfile)


## What is changed

* Clone from `snowdreamtech/frps`

* Change default configuration ini file



## FRPs ENV

* `FRP_TOKEN` is required, recommend to use complex password
* `FRP_PORT` default is `7000`


## FRPc examples

```editorconfig
[common]
server_addr = 222.222.222.222
server_port = 7000

authentication_method = token
authenticate_new_work_conns = true
token = xxxxxxxxxx

[plugin_socks]
type = tcp
remote_port = 2443
plugin = socks5
plugin_user = admin
plugin_passwd = xxxxxxxxxx
use_encryption = true
use_compression = true
```