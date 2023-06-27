# Ctyun-server


## What is changed

* Setup locale to Shanghai of CHINA
* Setup mirrors to ALIYUN of CHINA


# Alpine SSH

```shell
docker build --platform linux/arm64 -t changel/ctyun-server-arm64:2.0.1-220311-arm64
docker build --platform linux/amd64 -t changel/ctyun-server-amd64:2.0.1-220311-arm64

docker manifest create changel/ctyun-server:2.0.1-220311-arm64 \
        changel/ctyun-server-arm64:2.0.1-220311-arm64 \
        changel/ctyun-server-amd64:2.0.1-220311-arm64 \
        --amend

docker manifest annotate changel/ctyun-server:2.0.1-220311-arm64 \
      changel/ctyun-server-amd64:2.0.1-220311-arm64 \
      --os linux --arch amd64

docker manifest annotate changel/ctyun-server:2.0.1-220311-arm64 \
      changel/ctyun-server-arm64:2.0.1-220311-arm64 \
      --os linux --arch arm64

docker manifest push changel/ctyun-server:2.0.1-220311-arm64
```
