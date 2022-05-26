#!/bin/sh

#initialize manage environments
: ${ROCKETMQ_ROLE:?Set ROCKETMQ_ROLE to one of SERVER,BROKER,SLAVE}   # set role will auto configure
: ${SET_ROCKETMQ_brokerClusterName:=DefaultCluster}                   # cluster name
: ${SET_ROCKETMQ_brokerName:=$(hostname)}                             # default use hostname
: ${SET_ROCKETMQ_deleteWhen:=04}                                      # 4 clock in morning execute delete job
: ${SET_ROCKETMQ_fileReservedTime:=48}                                # keep last 48 hours data
: ${SET_ROCKETMQ_flushDiskType:=ASYNC_FLUSH}                          # async flush data to disk , data lost may occur
: ${SET_ROCKETMQ_storePathRootDir:=${ROCKETMQ_DATA}}                  # data directory by default set to ROCKET_DATA

: ${SET_ROCKETMQ_autoCreateTopicEnable:=false}                        # auto create topic , not recommand
: ${SET_ROCKETMQ_autoCreateSubscriptionGroup:=false}                  # auto create groupp, not recommand

# execute with non root user - java
EXECUTOR="exec su-exec java"

# check role and set up default value in configuration file
case "${ROCKETMQ_ROLE}" in
     SERVER)
          EXECUTOR="$EXECUTOR mqnamesrv"
     ;;
     BROKER)
          EXECUTOR="$EXECUTOR mqbroker -c ${ROCKETMQ_DATA}/broker.conf"
          : ${SET_ROCKETMQ_namesrvAddr:?namesrvAddr must be set}      # broker must setup namesrvAddr
          : ${SET_ROCKETMQ_brokerRole:=ASYNC_MASTER}                  # default set async broker master
          : ${SET_ROCKETMQ_brokerId:=0}                               # 0 represent master broker
          if [ "${SET_ROCKETMQ_brokerIP1:-x}" == "x" ];then
               SET_ROCKETMQ_brokerIP1=$(getent "ahosts" "$(hostname)" | awk '/STREAM/ {print $1 }' | head -n 1)
          fi
     ;;
     SLAVE)
          EXECUTOR="$EXECUTOR mqbroker -c ${ROCKETMQ_DATA}/broker.conf"
          : ${SET_ROCKETMQ_namesrvAddr:?namesrvAddr must be set}      # broker must setup namesrvAddr
          : ${SET_ROCKETMQ_brokerId:=1}                               # bigger than 0 represent slave 
          : ${SET_ROCKETMQ_brokerRole:=SLAVE}                         # slave
          if [ "${SET_ROCKETMQ_brokerIP1:-x}" == "x" ];then
               SET_ROCKETMQ_brokerIP1=$(getent "ahosts" "$(hostname)" | awk '/STREAM/ {print $1 }' | head -n 1)
          fi
     ;;
     *)
          echo "ROCKETMQ_ROLE should be set to one of SERVER,BROKER,SLAVE"
          exit 1
     ;;
esac

# make configuration file by environments startwith SET_ROCKETMQ_
test -f ${ROCKETMQ_DATA}/broker.conf && rm -f ${ROCKETMQ_DATA}/broker.conf

if [ "${ROCKETMQ_ROLE}" != "SERVER" ];then
     set | grep ^SET_ROCKETMQ_ | while read -r line
     do
         key=${line#SET_ROCKETMQ_}
         key=${key%%=*}
         value=$(echo ${line#*=}|sed 's/.\(.*\)/\1/' | sed 's/\(.*\)./\1/')
         echo "$key = $value" >> ${ROCKETMQ_DATA}/broker.conf
     done
fi


$EXECUTOR