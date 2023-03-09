FROM changel/alpine:3.17

# ** Install the necessary packages **
RUN apk add --no-cache dnsmasq wget nginx

ENV TFTP_HOME /var/lib/tftpboot
ENV HTML_HOME /var/lib/nginx/html

RUN set -ex \
  && mkdir -p $TFTP_HOME/grub \
  && mkdir -p ${HTML_HOME}/ubuntu

# Configure dnsmasq and nginx
COPY dnsmasq.conf /etc/
COPY nginx.conf /etc/nginx/

# ** Download iso file **
ENV UBUNTU_VERSION 20.04.5
ENV UBUNTU_CODE focal
# Alteadd iso in local
#ADD ubuntu-20.04.5-live-server-arm64.iso ${HTML_HOME}/ubuntu-20.04.5-live-server-arm64.iso
RUN set -ex \
    && wget https://cdimage.ubuntu.com/releases/${UBUNTU_VERSION%.*}/release/ubuntu-${UBUNTU_VERSION}-live-server-arm64.iso -O ${HTML_HOME}/ubuntu-${UBUNTU_VERSION}-live-server-arm64.iso

# ** Download grub file **
RUN set -ex \
    && wget http://ports.ubuntu.com/ubuntu-ports/dists/${UBUNTU_CODE}/main/uefi/grub2-arm64/current/grubnetaa64.efi.signed -O ${TFTP_HOME}/pxelinux.0

COPY grub.cfg /var/lib/tftpboot/grub/

# ** Configure kickstart file **
COPY meta-data /var/lib/nginx/html/
COPY user-data /var/lib/nginx/html/

# Add startup script
COPY run.sh /usr/local/bin/

CMD ["run.sh"]