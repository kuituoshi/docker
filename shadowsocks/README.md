# SHADOWSOCKS

* [`3.4.0`](https://github.com/kuituoshi/docker/blob/master/shadowsocks/3.4.0/Dockerfile)


## What is changed

* Clone from `breakwa11/shadowsocksr`

* Change encryption method or other parameters, default parameters are listed below 

```
ENV SERVER_ADDR     0.0.0.0
ENV SERVER_PORT     51348
ENV PASSWORD        psw
ENV METHOD          aes-128-ctr
ENV PROTOCOL        auth_aes128_md5
ENV PROTOCOLPARAM   32
ENV OBFS            tls1.2_ticket_auth_compatible
ENV TIMEOUT         300
ENV DNS_ADDR        8.8.8.8
ENV DNS_ADDR_2      8.8.4.4
```
