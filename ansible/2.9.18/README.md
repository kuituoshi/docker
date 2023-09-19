## Build Command

```shell
docker build --platform linux/arm64 -t changel/ansible-arm64:2.9.18 .
docker build --platform linux/amd64 -t changel/ansible-amd64:2.9.18 .
docker push changel/ansible-arm64:2.9.18
docker push changel/ansible-amd64:2.9.18

# remove manifest when it exist
# docker manifest rm changel/ansible:2.9.18
docker manifest create changel/ansible:2.9.18 \
        changel/ansible-arm64:2.9.18 \
        changel/ansible-amd64:2.9.18 \
        --amend

docker manifest annotate changel/ansible:2.9.18 \
      changel/ansible-amd64:2.9.18 \
      --os linux --arch amd64

docker manifest annotate changel/ansible:2.9.18 \
      changel/ansible-arm64:2.9.18 \
      --os linux --arch arm64

docker manifest push changel/ansible:2.9.18
```
