#!/bin/bash
#===按需修改ClOUD_TYPE和STEP参数
#cloud3      ##场景1 - 架构：天翼云3.0     系统：ctyunos2"
#cloud4      ##场景2 - 架构：天翼云4.0     系统：ctyunos2"
#xccloud     ##场景3 - 架构：天翼云3.0/4.0 系统：kylinsp1/sp2"
#kylinsp3    ##场景4 - 架构：天翼云3.0/4.0 系统：kylinsp3  海光3号、龙芯等时涉及"
#ctyunos3    ##场景5 - 架构：天翼云4.0     系统：ctyunos3  EMR类型主机等时涉及"
#hybrid3     ##场景6 - 架构：天翼云3.0     系统：kylinsp1/sp2+ctyunos2 即cloud3+xccloud组合"
#hybrid4     ##场景7 - 架构：天翼云4.0     系统：kylinsp1/sp2+ctyunos2 即cloud4+xccloud组合"
#===如没有合适匹配项,请反馈==="


ClOUD_TYPE=cloud4
STEP=all ##p2/p3 #p2系统和平台组件 p3为镜像 all为p2/p3
POOL_NAME=`hostname`   ##无需修改,默认为主机名
PULL_FILE=rsync_yum.sh
RSYNC_SCRIPTS=/tmp/rsync_yum.sh
TSA='121.237.176.8' #此为公网地址,当不通公网时可以根据实际情况按需修改(例如cn2等，但cn2禁止同步镜像等大文件)

## rsync pass file
echo "UlNZTkNfQkFDS1VQX1BBU1NXRF9CNHk1QGpVNjNuWDcxOAo="|base64 -d  >/etc/rsync.password
chmod 600 /etc/rsync.password

rsync --partial -avzuP rsync_backup@${TSA}::yum_rsync/script/${PULL_FILE:-noneaaa} ${RSYNC_SCRIPTS} --password-file=/etc/rsync.password
PULL_STATE=$(echo $?)
if [ ${PULL_STATE} -eq 0 ]; then
    flock -xn /var/run/rsync_yum.lock -c "/bin/bash ${RSYNC_SCRIPTS} ${POOL_NAME} ${ClOUD_TYPE} ${TSA} ${STEP}"
else
    rsync --partial -avzuP rsync_backup@${TSA}::yum_rsync/script/${PULL_FILE:-noneaaa} ${RSYNC_SCRIPTS} --password-file=/etc/rsync.password
    PULL_STATE=$(echo $?)
    if [ ${PULL_STATE} -eq 0 ]; then
        flock -xn /var/run/rsync_yum.lock -c "/bin/bash ${RSYNC_SCRIPTS} ${POOL_NAME} ${ClOUD_TYPE} ${TSA} ${STEP}"
    else
        echo "fail  $(date +%F' '%T) $(hostname)"  >${POOL_NAME}.yum_rsync.info
        rsync --delete -avz ${POOL_NAME}.yum_rsync.info rsync_backup@${TSA}::yum_rsync --password-file=/etc/rsync.password
    fi
fi

rm -f ${RSYNC_SCRIPTS} 2>/dev/null