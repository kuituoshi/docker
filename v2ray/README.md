# V2RAY

* [`4.23.1`](https://github.com/kuituoshi/docker/blob/master/v2ray/4.23.1/Dockerfile)
* [`tls-ws`](https://github.com/kuituoshi/docker/blob/master/v2ray/tls-ws/Dockerfile)


## What is changed

* Clone from `v2ray/official`

* Change default cofiguration json file

* Export 4443 port by default

* Inbound setting is `ws` network, path: `/websocket`, put nginx at front and ust TLS ,this is best choice

* Default Id is `df4d5522-a1ea-4a1a-a551-ef5cf40330b0`, change it before use


## tls-ws

* Out of the box

* `V2RAY_UUID` and `V2RAY_DOMAIN` env is required , if you want to change port, change `V2RAY_PORT`

* Setup Tls name to `p2plive-ali.douyucdn.cn` and Allow insecure TLS