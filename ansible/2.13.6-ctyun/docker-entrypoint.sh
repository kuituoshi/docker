#!/bin/sh

# main procedure
set -e

# startup ssh-agent
eval "$(ssh-agent -s)" >/dev/null
echo "Welcome to use HNKZ tools for CTYun Integration"
exec "$@"