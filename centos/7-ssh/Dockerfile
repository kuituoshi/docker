FROM changel/centos:7

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && yum install -y openssh-server passwd sshpass \
    && ssh-keygen -A \
    && mkdir /root/.ssh /docker-entrypoint-init.d \
    && echo "StrictHostKeyChecking no" >/root/.ssh/config \
    && echo "UserKnownHostsFile /dev/null" >>/root/.ssh/config \
    && yum clean all

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]