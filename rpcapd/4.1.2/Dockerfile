FROM changel/ubuntu:18.04 as builder

RUN set -ex \
    && apt update \
    && apt install -y bison flex unzip wget make \
    && wget http://www.winpcap.org/install/bin/WpcapSrc_4_1_2.zip \
    && unzip WpcapSrc_4_1_2.zip \
    && cd winpcap/wpcap/libpcap \
	&& chmod +x configure runlex.sh \
	&& CFLAGS=-static ./configure \
	&& make \
	&& cd rpcapd \
	&& make


FROM changel/ubuntu:18.04

MAINTAINER changel <changel@changel.cn>

COPY --from=builder /winpcap/wpcap/libpcap/rpcapd/rpcapd /usr/local/bin/rpcapd
COPY run.sh /usr/local/bin/


CMD ["run.sh"]