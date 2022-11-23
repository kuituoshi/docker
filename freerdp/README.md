# FreeRDP

* [`1.1.0`](https://github.com/kuituoshi/docker/blob/master/freerdp/1.1.0/Dockerfile)

## What is changed

* User `changel/ubuntu:18.04` base images
* Can run without **X11** environment
* Usage as Below
```bash
xfreerdp /v:192.168.1.100 +auth-only /d: /u:administrator /p:myPassword /sec:nla /cert-ignore
```