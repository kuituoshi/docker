### Build Image

```shell
image=fastcn-registry-changsha42.crs.ctyun.cn/hnkz/ansible:2.13.6-ctyun
docker buildx build -t $image --platform=linux/arm64,linux/amd64 . --push
```
