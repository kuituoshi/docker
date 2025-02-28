
### Build Image

```shell
# for sp1 amd64 
image=fastcn-registry-changsha42.crs.ctyun.cn/changel/nginx:ctyun-yum-rsync
docker buildx build -t $image --platform=linux/arm64,linux/amd64 . --push
```