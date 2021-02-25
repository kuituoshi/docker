#!/bin/sh

: ${RPCAPD_PORT:=2002}

echo "rpcapd starting port: ${RPCAPD_PORT}"
echo "Notice! IPV4 only support by default"

/usr/local/bin/rpcapd -4 -n -p ${RPCAPD_PORT}

