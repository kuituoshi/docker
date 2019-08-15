#!/bin/sh
set -e
chown -R activemq .
exec su-exec activemq /usr/local/activemq/bin/activemq console