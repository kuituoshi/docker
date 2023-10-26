#!/bin/sh

# main procedure
set -e

# startup ssh-agent
eval "$(ssh-agent -s)" >/dev/null
chmod 400 /root/.ssh/id_rsa
ssh-add /root/.ssh/id_rsa >/dev/null 2>&1
echo "Welcome to use HNKZ tools for CTYun Integration"
exec "$@"