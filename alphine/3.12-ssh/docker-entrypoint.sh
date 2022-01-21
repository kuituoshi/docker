#!/bin/sh

# main procedure
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- /usr/sbin/sshd "$@"
fi


if [ "$1" == "/usr/sbin/sshd" ];then
        if [ "${SSHD_ROOT_PASSWORD:-x}" != "x" ];then
            sed -i "s/#PermitRootLogin\ prohibit-password/PermitRootLogin\ yes/g" /etc/ssh/sshd_config
            sed -i "s/#PasswordAuthentication\ yes/PasswordAuthentication\ yes/g" /etc/ssh/sshd_config
            
            echo "root:${SSHD_ROOT_PASSWORD}" | chpasswd
        else
            # if you don't set password to '', you will not be allowed to login with PRIVATE_KEY
            passwd -d root
        fi
fi

exec "$@"