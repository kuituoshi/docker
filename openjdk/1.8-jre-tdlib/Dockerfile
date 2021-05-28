FROM changel/openjdk:1.8-jre

MAINTAINER changel <changel@changel.cn>

COPY --from=changel/tdlib:1.7.0 /usr/local/include/td /usr/local/include/td
COPY --from=changel/tdlib:1.7.0 /usr/local/lib/libtd* /usr/local/lib/
COPY --from=changel/tdlib:1.7.0 /usr/local/lib/libssl.a /usr/local/lib/libssl.a
COPY --from=changel/tdlib:1.7.0 /usr/local/lib/libcrypto.a /usr/local/lib/libcrypto.a
COPY --from=changel/tdlib:1.7.0 /usr/local/lib/libz.a /usr/local/lib/libz.a

        