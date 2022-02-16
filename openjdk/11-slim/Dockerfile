FROM adoptopenjdk/openjdk11:alpine-slim

RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.14/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.14/community" >>/etc/apk/repositories \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

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