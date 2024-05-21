#!/bin/bash
#cloud4  #天翼云4.0资源池 系统为ctyunos2
#cloud3  #天翼云3.0资源池 系统为ctyunos2
#xccloud #信创资源池      系统为kylin sp1 系统

ClOUD_TYPE=${1:-cloud4}
STEP=${2:-p2} ##p2/p3 #p2系统和平台组件 p3为镜像
POOL_NAME=`hostname`   ## 这里 other 改成资源池名称即可；例如：jiangsu03
PULL_FILE=rsync_yum.sh
RSYNC_SCRIPTS=/tmp/rsync_yum.sh
TSA='124.236.120.248'
#TSA='182.44.0.235'

## rsync pass file
echo "UlNZTkNfQkFDS1VQX1BBU1NXRAo="|base64 -d  >/etc/rsync.password
chmod 600 /etc/rsync.password

rsync --partial -avzuP rsync_backup@${TSA}::yum_rsync/script/${PULL_FILE:-noneaaa} ${RSYNC_SCRIPTS} --password-file=/etc/rsync.password
PULL_STATE=$(echo $?)
if [ ${PULL_STATE} -eq 0 ]; then
    flock -xn /var/run/rsync_yum.lock -c "/bin/sh ${RSYNC_SCRIPTS} ${POOL_NAME} ${ClOUD_TYPE} ${TSA} ${STEP}"
else
    rsync --partial -avzuP rsync_backup@${TSA}::yum_rsync/script/${PULL_FILE:-noneaaa} ${RSYNC_SCRIPTS} --password-file=/etc/rsync.password
    PULL_STATE=$(echo $?)
    if [ ${PULL_STATE} -eq 0 ]; then
        flock -xn /var/run/rsync_yum.lock -c "/bin/sh ${RSYNC_SCRIPTS} ${POOL_NAME} ${ClOUD_TYPE} ${TSA} ${STEP}"
    else
        echo "fail  $(date +%F' '%T) $(hostname)"  >${POOL_NAME}.yum_rsync.info
        rsync --delete -avz ${POOL_NAME}.yum_rsync.info rsync_backup@${TSA}::yum_rsync --password-file=/etc/rsync.password
    fi
fi

rm -f ${RSYNC_SCRIPTS} 2>/dev/null

