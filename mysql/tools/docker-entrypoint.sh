#!/bin/bash
set -eo pipefail

if [ "${1:0:1}" = '-' ]; then
	set -- innobackupex "$@"
fi

exec "$@"

