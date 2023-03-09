# PXE

* [`ubuntu20.04-arm64-uefi`](https://github.com/kuituoshi/docker/blob/master/pxe/ubuntu20.04-arm64-uefi/Dockerfile)

## How to use ubuntu20.04

### Default environment

* DNSMASQ_DHCP_RANGE 192.168.56.2,proxy
* DNSMASQ_DHCP_BOOT pxelinux.0
* PXE_ISO_NAME ubuntu-20.04-live-server-arm64.iso
* PXE_REPO_PATH http://$(get_default_ip), get_default_ip function to obtain local network ip

### How to use

```shell
sudo docker run -d --privileged --name pxe --net host -e DNSMASQ_DHCP_RANGE=172.16.95.10,172.16.95.20,255.255.255.0 changel/pxe:ubuntu20.04-arm64-uefi
```

