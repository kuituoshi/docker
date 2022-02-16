FROM changel/alpine:3.14

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apk add --no-cache tzdata --virtual .build-deps curl binutils zstd \
    && GLIBC_VER="2.33-r0" \
    && ALPINE_GLIBC_REPO="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" \
    && GCC_LIBS_URL="https://archive.archlinux.org/packages/g/gcc-libs/gcc-libs-10.1.0-2-x86_64.pkg.tar.zst" \
    && GCC_LIBS_SHA256="f80320a03ff73e82271064e4f684cd58d7dbdb07aa06a2c4eea8e0f3c507c45c" \
    && ZLIB_URL="https://archive.archlinux.org/packages/z/zlib/zlib-1%3A1.2.11-3-x86_64.pkg.tar.xz" \
    && ZLIB_SHA256=17aede0b9f8baa789c5aa3f358fbf8c68a5f1228c5e6cba1a5dd34102ef4d4e5 \
    && curl -LfsS https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && SGERRAND_RSA_SHA256="823b54589c93b02497f1ba4dc622eaef9c813e6b0f0ebbb2f771e32adf9f4ef2" \
    && echo "${SGERRAND_RSA_SHA256} */etc/apk/keys/sgerrand.rsa.pub" | sha256sum -c - \
    && curl -LfsS ${ALPINE_GLIBC_REPO}/${GLIBC_VER}/glibc-${GLIBC_VER}.apk > /tmp/glibc-${GLIBC_VER}.apk \
    && apk add --no-cache /tmp/glibc-${GLIBC_VER}.apk \
    && curl -LfsS ${ALPINE_GLIBC_REPO}/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk > /tmp/glibc-bin-${GLIBC_VER}.apk \
    && apk add --no-cache /tmp/glibc-bin-${GLIBC_VER}.apk \
    && curl -Ls ${ALPINE_GLIBC_REPO}/${GLIBC_VER}/glibc-i18n-${GLIBC_VER}.apk > /tmp/glibc-i18n-${GLIBC_VER}.apk \
    && apk add --no-cache /tmp/glibc-i18n-${GLIBC_VER}.apk \
    && /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true \
    && echo "export LANG=$LANG" > /etc/profile.d/locale.sh \
    && curl -LfsS ${GCC_LIBS_URL} -o /tmp/gcc-libs.tar.zst \
    && echo "${GCC_LIBS_SHA256} */tmp/gcc-libs.tar.zst" | sha256sum -c - \
    && mkdir /tmp/gcc \
    && zstd -d /tmp/gcc-libs.tar.zst --output-dir-flat /tmp \
    && tar -xf /tmp/gcc-libs.tar -C /tmp/gcc \
    && mv /tmp/gcc/usr/lib/libgcc* /tmp/gcc/usr/lib/libstdc++* /usr/glibc-compat/lib \
    && strip /usr/glibc-compat/lib/libgcc_s.so.* /usr/glibc-compat/lib/libstdc++.so* \
    && curl -LfsS ${ZLIB_URL} -o /tmp/libz.tar.xz \
    && echo "${ZLIB_SHA256} */tmp/libz.tar.xz" | sha256sum -c - \
    && mkdir /tmp/libz \
    && tar -xf /tmp/libz.tar.xz -C /tmp/libz \
    && mv /tmp/libz/usr/lib/libz.so* /usr/glibc-compat/lib \
    && apk del --purge .build-deps glibc-i18n \
    && rm -rf /tmp/*.apk /tmp/gcc /tmp/gcc-libs.tar* /tmp/libz /tmp/libz.tar.xz /var/cache/apk/*

# initial env
ENV JAVA_VERSION_MAJOR=11 \
    JAVA_VERSION_MINOR=11.0.13 \
    JAVA_PACKAGE=jdk \
    JAVA_HOME=/opt/jdk \
    JAVA_REPO=https://changel-repo.oss-cn-beijing.aliyuncs.com/java \
    PATH=${PATH}:/opt/jdk/bin

RUN set -ex \
    && apk add --no-cache curl \
    && curl -ssL -o /tmp/java.tar.gz ${JAVA_REPO}/${JAVA_PACKAGE}-${JAVA_VERSION_MINOR}_linux-x64_bin.tar.gz \
    && gunzip /tmp/java.tar.gz \
    && tar -C /tmp -xf /tmp/java.tar \
    && /tmp/${JAVA_PACKAGE}-${JAVA_VERSION_MINOR}/bin/jlink \
    --strip-debug \
    --compress 2 \
    --no-header-files \
    --no-man-pages \
    --output /opt/jdk \
    --add-modules java.base,java.compiler,java.datatransfer,java.xml,java.prefs,java.desktop,java.instrument,java.logging,java.management,java.security.sasl,java.naming,java.rmi,java.management.rmi,java.net.http,java.scripting,java.security.jgss,java.transaction.xa,java.sql,java.sql.rowset,java.xml.crypto,java.se,java.smartcardio,jdk.accessibility,jdk.internal.vm.ci,jdk.management,jdk.unsupported,jdk.internal.vm.compiler,jdk.internal.jvmstat,jdk.attach,jdk.charsets,jdk.compiler,jdk.crypto.ec,jdk.crypto.cryptoki,jdk.dynalink,jdk.internal.ed,jdk.editpad,jdk.hotspot.agent,jdk.httpserver,jdk.internal.le,jdk.internal.opt,jdk.internal.vm.compiler.management,jdk.jartool,jdk.javadoc,jdk.jcmd,jdk.management.agent,jdk.jconsole,jdk.jdeps,jdk.jdwp.agent,jdk.jdi,jdk.jfr,jdk.jlink,jdk.jshell,jdk.jsobject,jdk.jstatd,jdk.localedata,jdk.management.jfr,jdk.naming.dns,jdk.naming.ldap,jdk.naming.rmi,jdk.net,jdk.pack,jdk.rmic,jdk.scripting.nashorn,jdk.scripting.nashorn.shell,jdk.sctp,jdk.security.auth,jdk.security.jgss,jdk.unsupported.desktop,jdk.xml.dom,jdk.zipfs \
    && rm -rf /tmp/*

