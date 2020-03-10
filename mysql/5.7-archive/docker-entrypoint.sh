#!/bin/bash

set -e

: ${BACKUP_SOURCE_URL:?BACKUP_SOURCE_URL is REQUIRED!}
: ${BACKUP_SOURCE_PORT:=3306}
: ${BACKUP_SOURCE_USER:=root}
: ${BACKUP_SOURCE_PASS:?BACKUP_SOURCE_PASS is REQUIRED!}
: ${BACKUP_DEST_URL:?BACKUP_DEST_URL is REQUIRED!}
: ${BACKUP_DEST_PORT:=3306}
: ${BACKUP_DEST_USER:=root}
: ${BACKUP_DEST_PASS:?BACKUP_DEST_PASS is REQUIRED!}

: ${BACKUP_DATABASE:?BACKUP_DATABASE is REQUIRED!}
: ${BACKUP_MODE:=time}
if [ ${BACKUP_MODE} == 'define' ];then
	: ${BACKUP_DEFINE_NAME:?BACKUP_DEFINE_NAME is REQUIRED in define mode}
fi
if [ ${BACKUP_MODE} == 'prefix' ];then
	: ${BACKUP_PREFIX_NAME:?BACKUP_PREFIX_NAME is REQUIRED in prefix mode}
fi

src_mysql=(mysql -u${BACKUP_SOURCE_USER} -p${BACKUP_SOURCE_PASS} --port=${BACKUP_SOURCE_PORT} --host=${BACKUP_SOURCE_URL})
dst_mysql=(mysql -u${BACKUP_DEST_USER} -p${BACKUP_DEST_PASS} --port=${BACKUP_DEST_PORT} --host=${BACKUP_DEST_URL})

process_init_file() {
	local f="$1"; shift
	local mysql=( "$@" )

	case "$f" in
		*.sh)     echo "$0: running $f"; . "$f" ;;
		*.sql)    echo "$0: running $f"; "${mysql[@]}" < "$f"; echo ;;
		*.sql.gz) echo "$0: running $f"; gunzip -c "$f" | "${mysql[@]}"; echo ;;
		*)        echo "$0: ignoring $f" ;;
	esac
	echo
}

function find_src_database(){
	${src_mysql[@]} -e "show databases;" | awk -F "|" '{print $1}' | grep -q -x "$1"
	echo $?
}

function find_dst_database(){
	${dst_mysql[@]} -e "show databases;" | awk -F "|" '{print $1}' | grep -q -x "$1"
	echo $?
}


[ $(find_src_database ${BACKUP_DATABASE}) -eq 1 ] && { echo "${BACKUP_DATABASE} not found, process aborted." ; exit 1; }

if [ ${BACKUP_MODE} == 'same' ];then
	[ $(find_dst_database ${BACKUP_DATABASE}) -eq 0 ] && { echo "${BACKUP_DATABASE} already exists in destination, process aborted." ; exit 1; }
fi


echo "Database Backup 1: Starting backup database [${BACKUP_DATABASE}]"

if [ ${BACKUP_MODE} == 'time' ];then
	database_dest_name=${BACKUP_DATABASE}-$(date "+%Y%m%d")
elif [ ${BACKUP_MODE} == 'define' ];then
	database_dest_name=${BACKUP_DEFINE_NAME}
elif [ ${BACKUP_MODE} == 'same' ];then
	database_dest_name=${BACKUP_DATABASE}
elif [ ${BACKUP_MODE} == 'prefix' ];then
	database_dest_name=${BACKUP_PREFIX_NAME}-${BACKUP_DATABASE}-$(date "+%Y%m%d")
else
	echo "BACKUP_MODE must be set one of [same, define, time, prefix]"
	exit 1
fi

create_schema_sql="CREATE SCHEMA \`${database_dest_name}\` DEFAULT CHARACTER SET utf8 ;"


echo "Database Backup 2: Creating database [${database_dest_name}] in destination Server"
[ $(find_dst_database ${database_dest_name}) -eq 0 ] && { echo "${database_dest_name} already exists in destination, process aborted." ; exit 1; }

# create database in destination server
${dst_mysql[@]} -e "${create_schema_sql}"


dst_mysql=(${dst_mysql[@]} ${database_dest_name})
# replace mysql command with mysqldump
src_mysql[0]=mysqldump
mysqldump=(${src_mysql[@]} --default-character-set=utf8 --max-allowed-packet=1G --routines --events --single-transaction --triggers ${BACKUP_DATABASE})

${mysqldump[@]} | ${dst_mysql[@]}
if [ $? -eq 1 ];then
	echo "Database Backup 3: Backup database failed"
	exit 1
fi

echo "Database Backup 3: Backup database successfully"


for f in /docker-entrypoint-initdb.d/*; do
	process_init_file "$f" "${dst_mysql[@]}"
done

echo "Database Backup 4: Running extra files in /docker-entrypoint-initdb.d"