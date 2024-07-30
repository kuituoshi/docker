#!/bin/bash

RSYNC_SERVER_IP=${1:-124.236.120.248}
RSYNC_USER=${2:-rsync_backup}
RSYNC_PASSWORD=${3:-RSYNC_BACKUP_PASSWD}

CTyunPath=/data/repo/yum/ctyun

RESET=''
RED=''
GREEN=''
YELLOW=''
MAGENTA=''
CYAN=''

stderr_print() {
    local bool="${BITNAMI_QUIET:-false}"
    shopt -s nocasematch
    if ! [[ "$bool" = 1 || "$bool" =~ ^(yes|true)$ ]]; then
        printf "%b\\n" "${*}" >&2
        echo "${*}" >> /tmp/rsync.log
    fi
}

log() {
    stderr_print "${CYAN}${MODULE:-} ${MAGENTA}$(date "+%T.%2N ")${RESET}${*}"
}
info() {
    log "INFO ==> ${*}"
}
error() {
    log "ERROR ==> ${*}"
}

sync_yum(){
    sync_path=$1
    rsync --delete -avzP ${RSYNC_USER}@${RSYNC_SERVER_IP}::data/${sync_path} ${CTyunPath}/${sync_path} --password-file=/etc/sync.pwd
}

get_valid_line(){
    valid_lines=""
    while read -r line;do
        path=$(echo "$line"|awk '{print $2}')
        size=$(echo "$line"|awk '{print $1}')
        if [[ ! $size =~ ^[0-9]+(\.[0-9]+)?(G|M)$ ]];then
            continue
        fi
        if [ "$path" == "total" ];then
            continue
        fi
        valid_lines+="${size} ${path}\n"
    done<$1
    echo -e ${valid_lines}
}

#####################RUNNING##############################
# make rsync password file
echo "${RSYNC_PASSWORD}" >/etc/sync.pwd
chmod 400 /etc/sync.pwd

# make sure ctyun path exists
test -d ${CTyunPath} || mkdir -p ${CTyunPath}

# sync yum size and add new directory in it
sync_yum yum_size.txt
echo '1G offline-pkgs/' >>${CTyunPath}/yum_size.txt
echo '1G ctyunos/ctyunkylinos/' >>${CTyunPath}/yum_size.txt
echo '1G xccloud/kylin_sp3/' >>${CTyunPath}/yum_size.txt
echo '1G images/images-os/base/' >>${CTyunPath}/yum_size.txt


# start to sync
log "Ready for syncing repository"

get_valid_line ${CTyunPath}/yum_size.txt |while read -r line;do
    path=$(echo "$line"|awk '{print $2}')
    size=$(echo "$line"|awk '{print $1}')
    local_path=${CTyunPath}/$path
    test -d ${local_path} || mkdir -p ${local_path}
    before_size=$(du -sh ${local_path}|awk '{print $1}')
    sync_yum $path
    after_size=$(du -sh ${local_path}|awk '{print $1}')
    info "before_size: ${before_size} , after_size: ${after_size}, remote_size: $size, path: $path"
done

info "sync finished"
rm -f /etc/sync.pwd