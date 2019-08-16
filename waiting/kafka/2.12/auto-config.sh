#!/bin/sh

# setup default configuration values
# be care of setting up values with prefix,and export them

set -e

#get server internet IP

if [ ${MY_SERVER_INTERNET_IP:-x} == 'x' ];then
    MY_SERVER_INTERNET_IP=$(curl -sS icanhazip.com)
fi


SET_KAFKA_ADVERTISED_LISTENERS=INSIDE://:9092,OUTSIDE://${MY_SERVER_INTERNET_IP}:$(expr 9100 + ${SET_KAFKA_BROKER_ID})
export SET_KAFKA_ADVERTISED_LISTENERS
echo "Your Server Internet IP is: ${MY_SERVER_INTERNET_IP}"
echo "Advertised.Listeners is: ${SET_KAFKA_ADVERTISED_LISTENERS}"


# setup prefix and directory where to store configuration
config_file="/tmp/kafka.conf"
env_prefix="SET_KAFKA_"

# remove temporary configuration file 
test -f ${config_file} && rm -f ${config_file}
# convert system env to key&value,setup configuration file
env | grep ^${env_prefix} | while read -r line
do
    tmp_key=${line#${env_prefix}}
    tmp_key=$(echo ${tmp_key%%=*}| tr '[A-Z]' '[a-z]' | tr _ .)
    tmp_value=${line#*=}
    if [ ${tmp_value:-x} == "x" ];then
        echo "ERROR! \"${tmp_key}\" can't be set to null"
        exit 1
    fi
    echo "${tmp_key}=${tmp_value}" >> ${config_file}
done


kafka-server-start.sh ${config_file}