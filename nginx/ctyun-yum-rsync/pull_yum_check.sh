#!/bin/bash

RESET='\033[0m'
RED='\033[38;5;1m'
GREEN='\033[38;5;2m'
YELLOW='\033[38;5;3m'
MAGENTA='\033[38;5;5m'
CYAN='\033[38;5;6m'

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
    log "${GREEN}INFO ${RESET} ==> ${*}"
}
warn() {
    log "${YELLOW}WARN ${RESET} ==> ${*}"
}
error() {
    log "${RED}ERROR${RESET} ==> ${*}"
}

sync_yum(){
    sync_path=$1
    rsync --delete --partial -avzuP rsync_backup@124.236.120.248::data/${sync_path} /data/repo/yum/ctyun/${sync_path} --password-file=/etc/rsync.password
}

cd /data/repo/yum/ctyun
curl -sSL http://124.236.120.248:50001/ctyun/yum_size.txt -o /tmp/yum_size.txt
log "Get yum size file from official repository"

while read -r line;do
    path=$(echo "$line"|awk '{print $2}')
    size=$(echo "$line"|awk '{print $1}')
    if [[ ! $size =~ ^[0-9]+(\.[0-9]+)?(G|M)$ ]];then
        continue
    fi
    if [ ! -e $path ];then
        continue
    fi
    local_size=$(du -sh $path|awk '{print $1}')
    info "local size: ${local_size}, remote size: $size, path: $path"
    sync_yum $path
    new_local_size=$(du -sh $path|awk '{print $1}')
    info "local size: ${new_local_size}, remote size: $size, path: $path"
done</tmp/yum_size.txt

info "sync finished"