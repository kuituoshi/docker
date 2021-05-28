#!/bin/sh

# setup default configuration values
# be care of setting up values with prefix,and export them

#: ${REDIS_BIND:-0.0.0.0}
#: ${REDIS_PROTECTED_MODE:-yes}
#: ${REDIS_DAEMONIZE:-no}
#: ${REDIS_DIR:-/data}

set -e
# setup prefix and directory where to store configuration
config_file="/tmp/redis.cnf"
env_prefix="SET_REDIS_"

# remove temporary configuration file 
test -f ${config_file} && rm -f ${config_file}
# convert system env to key&value,setup configuration file
env | grep ^${env_prefix} | while read -r line
do
    tmp_key=${line#${env_prefix}}
    tmp_key=$(echo ${tmp_key%%=*}| tr '[A-Z]' '[a-z]')
    tmp_key=${tmp_key//_/-}
    tmp_value=${line#*=}
    if [ ${tmp_value:-x} == "x" ];then
        echo "ERROR! \"${tmp_key}\" can't be set to null"
        exit 1
    fi
    echo "${tmp_key} ${tmp_value}" >> ${config_file}
done

chown -R redis .
exec su-exec redis redis-server ${config_file}