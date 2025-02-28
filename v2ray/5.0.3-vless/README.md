
### Build Image

```shell
# for sp1 amd64 
image=fastcn-registry-changsha42.crs.ctyun.cn/hnkz/rsync:3.1.3
docker buildx build -t $image --platform=linux/arm64,linux/amd64 . --push
```