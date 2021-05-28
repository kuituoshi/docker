FROM adoptopenjdk/openjdk8:alpine-slim

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && apk add --no-cache curl \
    && mkdir -p /usr/share/maven /var/lib/maven \
    && curl -fsSL -o /tmp/apache-maven-3.6.3-bin.tar.gz https://mirror-hk.koddos.net/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz \
    && tar -xzf /tmp/apache-maven-3.6.3-bin.tar.gz -C /usr/share/maven --strip-components=1 \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
    && ln -s /var/lib/maven /root/.m2 \
    && apk del curl \
    && rm -rf /var/cache/apk/* /tmp/*

COPY settings.xml /var/lib/maven/

CMD ["mvn"]