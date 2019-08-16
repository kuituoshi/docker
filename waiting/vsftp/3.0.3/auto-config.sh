#!/bin/sh

# setup default configuration values
# be care of setting up values with prefix,and export them

set -e

#get server internet IP
if [ ${SET_VSFTPD_PASV_ADDRESS:-x} == 'x' ];then
	SET_VSFTPD_PASV_ADDRESS=$(curl -sS icanhazip.com)
	export SET_VSFTPD_PASV_ADDRESS
fi

echo "Your FTP Server internet IP is: ${SET_VSFTPD_PASV_ADDRESS}"

# setup prefix and directory where to store configuration
config_file="/etc/vsftpd.conf"
env_prefix="SET_VSFTPD_"

# remove temporary configuration file 
test -f ${config_file} && rm -f ${config_file}
# convert system env to key&value,setup configuration file
env | grep ^${env_prefix} | while read -r line
do
    tmp_key=${line#${env_prefix}}
    tmp_key=$(echo ${tmp_key%%=*}| tr '[A-Z]' '[a-z]')
    tmp_value=${line#*=}
    if [ ${tmp_value:-x} == "x" ];then
        echo "ERROR! \"${tmp_key}\" can't be set to null"
        exit 1
    fi
    echo "${tmp_key}=${tmp_value}" >> ${config_file}
done

test -d /data/ftp || mkdir -p /data/ftp
test -d /data/${GEN_VSFTPD_USERNAME} || mkdir -p /data/${GEN_VSFTPD_USERNAME}
id  ${GEN_VSFTPD_USERNAME} || addgroup -g 1000 -S ${GEN_VSFTPD_USERNAME}
id  ${GEN_VSFTPD_USERNAME} || adduser -D -s /bin/false  -h /data/${GEN_VSFTPD_USERNAME} -u 1000 -G ${GEN_VSFTPD_USERNAME} ${GEN_VSFTPD_USERNAME}
chown -R ${GEN_VSFTPD_USERNAME}:${GEN_VSFTPD_USERNAME} /data/${GEN_VSFTPD_USERNAME} /data/ftp
echo "${GEN_VSFTPD_USERNAME}:${GEN_VSFTPD_PASSWORD}" | chpasswd

vsftpd