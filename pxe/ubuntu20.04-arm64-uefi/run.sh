#!/bin/sh

get_default_ip() {
    local default_iface=$(awk '$2 == 00000000 { print $1 }' /proc/net/route)
    ip addr show dev "$default_iface" | awk '$1 == "inet" { sub("/.*", "", $2); print $2 }'
}

: ${DNSMASQ_DHCP_RANGE:=192.168.56.2,proxy}
: ${DNSMASQ_DHCP_BOOT:=pxelinux.0}
: ${PXE_ISO_NAME:=ubuntu-${UBUNTU_VERSION}-live-server-arm64.iso}
: ${PXE_REPO_PATH:=http://$(get_default_ip)}


echo "PXE: 启动参数信息"
echo "PXE: 默认网卡IP -> $(get_default_ip)"
echo "PXE: DHCP池 -> ${DNSMASQ_DHCP_RANGE}"
echo "PXE: DHCP启动文件 -> ${DNSMASQ_DHCP_BOOT}"
echo "PXE: 仓库地址 -> ${PXE_REPO_PATH}"
echo "PXE: ISO名称 -> ${PXE_ISO_NAME}"


sed -i \
	-e "s#PXE_ISO_NAME#${PXE_ISO_NAME}#g" \
	-e "s#PXE_REPO_PATH#${PXE_REPO_PATH}#g" \
	${TFTP_HOME}/grub/grub.cfg

# 挂载到ubuntu目录
mount -o loop -t iso9660 ${HTML_HOME}/ubuntu-${UBUNTU_VERSION}-live-server-arm64.iso ${HTML_HOME}/ubuntu
ln -sf ${HTML_HOME}/ubuntu/boot/grub/arm64-efi ${TFTP_HOME}/grub/arm64-efi
ln -sf ${HTML_HOME}/ubuntu/boot/grub/font.pf2  ${TFTP_HOME}/grub/font.pf2
ln -sf ${HTML_HOME}/ubuntu/casper ${TFTP_HOME}/casper


nginx

dnsmasq --no-daemon \
        --dhcp-range=${DNSMASQ_DHCP_RANGE} \
        --dhcp-boot=${DNSMASQ_DHCP_BOOT}



