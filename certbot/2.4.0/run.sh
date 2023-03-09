#!/bin/sh

if [ "${1:0:1}" = '-' ]; then
	set -- certbot "$@"
fi

if [ "$1" == "certbot" ];then
    # setup default configuration values
    : ${DNS:?DNS is required, Comma-separated}

    certbot certonly -d $DNS --manual --preferred-challenges dns-01  --server https://acme-v02.api.letsencrypt.org/directory
else
    $@
fi

