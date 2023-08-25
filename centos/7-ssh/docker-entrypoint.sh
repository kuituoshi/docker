#!/bin/sh

# main procedure
set -e

process_init_file() {
	local f="$1";

	case "$f" in
		*.sh)     echo "SSHD BOOTING: Running  initial script $f"; . "$f" ;;
		*)        echo "SSHD BOOTING: Ignoring $f" ;;
	esac
}

if [ "${1:0:1}" = '-' ]; then
	set -- /usr/sbin/sshd "$@"
fi


if [ "$1" == "/usr/sbin/sshd" ];then
        if [ "${SSHD_ROOT_PASSWORD:-x}" != "x" ];then
            sed -i "s/#PermitRootLogin\ prohibit-password/PermitRootLogin\ yes/g" /etc/ssh/sshd_config
            sed -i "s/#PasswordAuthentication\ yes/PasswordAuthentication\ yes/g" /etc/ssh/sshd_config
            sed -i "s/#UseDNS\ yes/UseDNS\ no/g" /etc/ssh/sshd_config

            echo "root:${SSHD_ROOT_PASSWORD}" | chpasswd
        else
            # if you don't set password to '', you will not be allowed to login with PRIVATE_KEY
            passwd -d root
        fi
fi

# Run scripts in docker-entrypoint-init.d
for f in /docker-entrypoint-init.d/*; do
	process_init_file "$f"
done

exec "$@"