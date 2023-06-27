#!/bin/sh
set -eo pipefail

#initialize manage environments
: ${RSYNC_TIMEOUT:=300}
: ${RSYNC_MODULE:=data}
: ${RSYNC_PATH:=/data}
: ${RSYNC_USER:=rsync}
: ${RSYNC_PASSWORD:?RSYNC_PASSWORD is missing}

echo "启动参数"
echo "超时时间: ${RSYNC_TIMEOUT}"
echo "同步模块: ${RSYNC_MODULE}"
echo "模块目录: ${RSYNC_PATH}"
echo "访问用户: ${RSYNC_USER}"
echo "访问密码: ${RSYNC_PASSWORD}"

if [ ! -f /etc/rsync.pwd ];then
  sed -i "s/RSYNC_TIMEOUT/${RSYNC_TIMEOUT}/g" /etc/rsyncd.conf
  sed -i "s/RSYNC_MODULE/${RSYNC_MODULE}/g" /etc/rsyncd.conf
  sed -i "s#RSYNC_PATH#${RSYNC_PATH}#g" /etc/rsyncd.conf
  sed -i "s/RSYNC_USER/${RSYNC_USER}/g" /etc/rsyncd.conf
  echo "${RSYNC_USER}:${RSYNC_PASSWORD}" > /etc/rsync.pwd
  chmod 400 /etc/rsync.pwd
fi

rsync --daemon
sleep 99d