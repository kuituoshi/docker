FROM changel/alpine:3.9

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
    && apk add --no-cache openssh-server openssh \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key \
    && ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key \
    && mkdir /root/.ssh \
    && echo "StrictHostKeyChecking no" >/root/.ssh/config \
    && echo "UserKnownHostsFile /dev/null" >>/root/.ssh/config


COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]