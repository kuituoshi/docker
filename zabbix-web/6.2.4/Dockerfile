FROM zabbix/zabbix-web-nginx-mysql:alpine-6.2.4

USER root

# replace mirror with aliyun
RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.16/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.16/community" >>/etc/apk/repositories

# replace font
RUN set -ex \
    && curl -sSL -o /usr/share/zabbix/assets/fonts/simsun.ttf http://repo.changel.cn/ttf/simsun.ttf \
    && sed -i 's/DejaVuSans/simsun/g' /usr/share/zabbix/include/defines.inc.php

USER zabbix