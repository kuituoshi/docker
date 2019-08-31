FROM changel/ubuntu:18.04

RUN apt-get update \
    && apt-get -y install strongswan kmod iptables uuid-runtime strongswan-pki openssl libstrongswan-standard-plugins libcharon-standard-plugins libcharon-extra-plugins \
    && rm -rf /var/lib/apt/lists/* \
    && rm /etc/ipsec.secrets

ADD ./etc/* /etc/
ADD ./bin/* /usr/bin/

EXPOSE 500/udp 4500/udp

WORKDIR /data

CMD /usr/bin/start-vpn