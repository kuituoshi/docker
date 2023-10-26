## Build Command

```shell
docker build --platform linux/arm64 -t changel/ansible-arm64:6.6.0-ctyun .
docker build --platform linux/amd64 -t changel/ansible-amd64:6.6.0-ctyun .
docker push changel/ansible-arm64:6.6.0-ctyun
docker push changel/ansible-amd64:6.6.0-ctyun

# remove manifest when it exist
docker manifest rm changel/ansible:6.6.0-ctyun
docker manifest create changel/ansible:6.6.0-ctyun \
        changel/ansible-arm64:6.6.0-ctyun \
        changel/ansible-amd64:6.6.0-ctyun \
        --amend

docker manifest annotate changel/ansible:6.6.0-ctyun \
      changel/ansible-amd64:6.6.0-ctyun \
      --os linux --arch amd64

docker manifest annotate changel/ansible:6.6.0-ctyun \
      changel/ansible-arm64:6.6.0-ctyun \
      --os linux --arch arm64

docker manifest push changel/ansible:6.6.0-ctyun
```
