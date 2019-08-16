FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& sed -i "s/archive/cn.archive/g" /etc/apt/sources.list \
	&& apt-get update -qq && apt-get install -y nfs-kernel-server runit inotify-tools -qq \
	&& apt-get clean

#Config NFS,when you create /exports you should change the privileges to normal user who want to connect to NAS
RUN mkdir -p /etc/sv/nfs /exports \
	&& echo '#!/bin/bash ' >/etc/sv/nfs/run \
	&& echo '. /etc/default/nfs-kernel-server ' >>/etc/sv/nfs/run \
	&& echo '. /etc/default/nfs-common ' >>/etc/sv/nfs/run \
	&& echo 'rpcbind ' >>/etc/sv/nfs/run \
	&& echo 'service nfs-kernel-server start ' >>/etc/sv/nfs/run \
	&& echo 'exec inotifywait -m /exports ' >>/etc/sv/nfs/run \
	&& echo "##########################################################" \
	&& echo '#!/bin/bash' >/etc/sv/nfs/finish \
	&& echo 'service nfs-kernel-server stop' >>/etc/sv/nfs/finish \
	&& echo 'kill $(pidof rpcbind)' >>/etc/sv/nfs/finish \
	&& echo 'service rsyslog stop' >>/etc/sv/nfs/finish \
	&& echo "/exports *(rw,async,no_subtree_check,fsid=0,no_root_squash)" > /etc/exports \
	&& chmod 755 /etc/sv/nfs/*


#your should mount /exports volume 
EXPOSE 111/udp 2049/tcp

CMD exec runsvdir /etc/sv