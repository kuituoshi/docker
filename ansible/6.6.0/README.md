## Build Command

```shell
docker build --platform linux/arm64 -t changel/ansible-arm64:6.6.0 .
docker build --platform linux/amd64 -t changel/ansible-amd64:6.6.0 .
docker push changel/ansible-arm64:6.6.0
docker push changel/ansible-amd64:6.6.0

# remove manifest when it exist
# docker manifest rm changel/ansible:6.6.0
docker manifest create changel/ansible:6.6.0 \
        changel/ansible-arm64:6.6.0 \
        changel/ansible-amd64:6.6.0 \
        --amend

docker manifest annotate changel/ansible:6.6.0 \
      changel/ansible-amd64:6.6.0 \
      --os linux --arch amd64

docker manifest annotate changel/ansible:6.6.0 \
      changel/ansible-arm64:6.6.0 \
      --os linux --arch arm64

docker manifest push changel/ansible:6.6.0
```
