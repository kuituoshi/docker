# Kylin-server


## What is changed

* Setup locale to Shanghai of CHINA
* Setup mirrors to ALIYUN of CHINA


# Alpine SSH

```shell
docker build --platform linux/arm64 -t changel/kylin-server-arm64:10-sp1-build04-20200711
docker build --platform linux/amd64 -t changel/kylin-server-amd64:10-sp1-build04-20200711

docker manifest create changel/kylin-server:10-sp1-build04-20200711 \
        changel/kylin-server-arm64:10-sp1-build04-20200711 \
        changel/kylin-server-amd64:10-sp1-build04-20200711 \
        --amend

docker manifest annotate changel/kylin-server:10-sp1-build04-20200711 \
      changel/kylin-server-amd64:10-sp1-build04-20200711 \
      --os linux --arch amd64

docker manifest annotate changel/kylin-server:10-sp1-build04-20200711 \
      changel/kylin-server-arm64:10-sp1-build04-20200711 \
      --os linux --arch arm64

docker manifest push changel/kylin-server:10-sp1-build04-20200711
```
