# V2RAY

* [`5.0.3-vmess`](https://github.com/kuituoshi/docker/blob/master/v2ray/5.0.3-vmess/Dockerfile)
* [`5.0.3-vless`](https://github.com/kuituoshi/docker/blob/master/v2ray/5.0.3-vless/Dockerfile)
* [`tls-ws`](https://github.com/kuituoshi/docker/blob/master/v2ray/tls-ws/Dockerfile)


## What is changed

* Clone from `teddysun/v2ray`

* Change default cofiguration json file

* Inbound setting is `ws` network, path: `/websocket`, put nginx at front and ust TLS ,this is best choice



## VMESS ENV

* `V2RAY_UUID` create random uuid if not specify
* `V2RAY_DOMAIN` default is `ws.flyaway2oversea.com`, if you use public certificate, put `server.crt` and `server.key` in /etc/v2ray/certs/
* `V2RAY_PORT` default is `443`
* `V2RAY_TIMEOUT` default is `600` seconds
* `V2RAY_VMESS_AEAD_FORCED` default is `false`, see [VmessAEAD](https://github.com/233boy/v2ray/issues/812)
* `V2RAY_LOG_LEVEL` default is `warning`
