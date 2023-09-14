FROM alpine:3.12

RUN set -ex \
    && echo "https://mirrors.aliyun.com/alpine/v3.12/main" >/etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.12/community" >>/etc/apk/repositories \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN set -ex \
	&& mkdir /root/.pip \
	&& echo '[global]' > /root/.pip/pip.conf \
	&& echo 'index-url = http://mirrors.aliyun.com/pypi/simple/' >> /root/.pip/pip.conf \
	&& echo '[install]' >> /root/.pip/pip.conf \
	&& echo 'trusted-host=mirrors.aliyun.com' >> /root/.pip/pip.conf \

# update pip to lastest version
RUN set -ex \
    && apk add --no-cache python3 py3-pip \
    && pip install -U pip

# install ansible
RUN set -ex \
    && apk add --no-cache ansible

# install dependency
RUN set -ex \
    && apk add --no-cache openssh-client sshpass bash \
    && mkdir /root/.ssh \
    && echo "StrictHostKeyChecking no" >/root/.ssh/config \
    && echo "UserKnownHostsFile /dev/null" >>/root/.ssh/config

RUN set -ex \
    && pip install pywinrm \
    && ansible-galaxy collection install ansible.windows