#!/bin/bash

# setup default configuration values
# be care of setting up values with prefix,and export them
: ${SET_MYSQLD_FILE:=no}
: ${SET_MYSQLD_MASTER:=no}
: ${SET_MYSQLD_SLAVE:=no}
: ${SET_MYSQLD_REPL_PASSWORD:=repl}

#standalone
: ${MYSQLD_CHARACTER_SET_SERVER:=utf8}
: ${MYSQLD_PID_FILE:=/var/run/mysqld/mysqld.pid}
: ${MYSQLD_SOCKET:=/var/run/mysqld/mysqld.sock}
: ${MYSQLD_DATADIR:=/var/lib/mysql}
: ${MYSQLD_LOWER_CASE_TABLE_NAMES:=1}
: ${MYSQLD_USER:=mysql}
: ${MYSQLD_LOG_BIN_TRUST_FUNCTION_CREATORS:=0}
: ${MYSQLD_EXPIRE_LOGS_DAYS:=0}

#cluster
: ${MYSQLD_INNODB_FLUSH_LOG_AT_TRX_COMMIT:=2}
: ${MYSQLD_GTID_MODE:=ON}
: ${MYSQLD_ENFORCE_GTID_CONSISTENCY:=ON}
: ${MYSQLD_MASTER_INFO_REPOSITORY:='TABLE'}
: ${MYSQLD_RELAY_LOG_INFO_REPOSITORY:='TABLE'}
: ${MYSQLD_SLAVE_PARALLEL_WORKERS:=0}
: ${MYSQLD_RELAY_LOG_RECOVERY:=0}


set -e
# setup prefix and directory where to store configuration
config_file="/etc/mysql/my.cnf"
env_prefix="MYSQLD_"

if [ "${1:0:1}" = '-' ]; then
	set -- mysqld "$@"
fi

# convert system env to key&value,setup configuration file
if [ "${SET_MYSQLD_FILE}" == "no" -a "$1" == "mysqld" ];then
        test -f ${config_file} && rm -f ${config_file}
        echo '[mysqld]' >> ${config_file}
        echo '!includedir /etc/mysql/conf.d/' >> ${config_file}
        
        #begin to insert configurations
        set | grep ^${env_prefix} | while read -r line
        do
            tmp_key=${line#${env_prefix}}
            if [ "${tmp_key:0:4}" == "LINE" ];then
                tmp_key=${tmp_key#LINE_}
                tmp_key=${tmp_key//_/-} 
            fi
            tmp_key=$(echo ${tmp_key%%=*}| tr '[A-Z]' '[a-z]')
            tmp_value=${line#*=}
            if [ "${tmp_value:-x}" == "x" ];then
                echo "ERROR! \"${tmp_key}\" can't be set to null"
                exit 1
            fi
            echo "${tmp_key} = ${tmp_value}" >> ${config_file}
        done
        #because entrypoint user is mysql
        chown mysql:root ${config_file}

        ###setup server replication
        if [ "${SET_MYSQLD_MASTER}" == "yes" -a "${SET_MYSQLD_SLAVE}" == "yes" ];then
                echo "\n you cant set both MASTER and SLAVE state"
                exit 1
        elif [ "${SET_MYSQLD_MASTER}" == "yes" ];then
                ## auto setup server id
                test "${MYSQLD_SERVER_ID:-x}" == "x" && echo "server_id = 1" >> ${config_file}
                test "${MYSQLD_LOG_BIN:-x}" == "x" && echo "log_bin = mysql-binlog" >> ${config_file}

                ##make sure scripts are executed at last
                if [ ! -d "${MYSQLD_DATADIR}/mysql" ]; then
                    cat <<-EOSQL >/docker-entrypoint-initdb.d/create_user.sql
                        CREATE USER 'repl'@'%' IDENTIFIED BY '${SET_MYSQLD_REPL_PASSWORD}';
                        GRANT REPLICATION SLAVE,REPLICATION CLIENT ON *.* TO 'repl'@'%';
					EOSQL
                fi
                if [ "${MYSQLD_RPL_SEMI_SYNC_MASTER_ENABLED:-x}" == "x" ];then
                    echo "rpl_semi_sync_master_enabled = ON" >> ${config_file}
                    echo 'plugin-load="rpl_semi_sync_master=semisync_master.so"' >> ${config_file}
                fi
                echo "Starting Master Server...."
        elif [ "${SET_MYSQLD_SLAVE}" == "yes" ];then
                if [ "${SET_MYSQLD_SLAVE_MASTER_NAME:-x}" == "x" ];then
                    echo "Error Please setup SET_MYSQLD_SLAVE_MASTER_NAME for connecting to master"
                    exit 1
                fi

                ## auto setup server id
                if [ "${MYSQLD_SERVER_ID:-x}" == "x" ];then
                        pod_index=($(echo $(hostname) | tr "-" "\n"))
                        test ${#pod_index[@]} -lt 2 && echo "Not K8s environment, please setup MYSQLD_SERVER_ID" && exit 1
                        expr 20 "+" ${pod_index[-1]} &>/dev/null
                        test $? -ne 0 && echo "Not K8s environment, please setup MYSQLD_SERVER_ID" && exit 1
                        index=$(expr 20 "+" ${pod_index[-1]})
                        echo "server_id = ${index}" >> ${config_file}
                fi

                test "${MYSQLD_RELAY_LOG:-x}" == "x" && echo "relay_log = mysql-relaylog" >> ${config_file}
                test "${MYSQLD_READ_ONLY:-x}" == "x" && echo "read_only = 1" >> ${config_file}

                ##make sure scripts are executed at last
                if [ ! -d "${MYSQLD_DATADIR}/mysql" ]; then
                    cat <<-EOSQL >/docker-entrypoint-initdb.d/create_user.sql
                        CHANGE MASTER TO MASTER_HOST='${SET_MYSQLD_SLAVE_MASTER_NAME}',
                        MASTER_USER='repl',
                        MASTER_PASSWORD='${SET_MYSQLD_REPL_PASSWORD}',
                        MASTER_AUTO_POSITION=1 for CHANNEL '${SET_MYSQLD_SLAVE_MASTER_NAME}';
                        start slave for channel '${SET_MYSQLD_SLAVE_MASTER_NAME}';
					EOSQL
                    #if slave set pull master to setup database ,you should specify this env
                    if [ "${SET_MYSQLD_PULL_PASSWORD:-x}" != "x" ];then
                        cat <<-"EOSQL" >/docker-entrypoint-initdb.d/aa-pull-master.sh
                            #!/bin/bash
                            get_databases=$(mysql -uroot -p${SET_MYSQLD_PULL_PASSWORD} --host=${SET_MYSQLD_SLAVE_MASTER_NAME}  -e "show databases;"  |grep -E -v "Database|information_schema|mysql|performance_schema|sys" )
                            mysqldump --single-transaction -uroot -p${SET_MYSQLD_PULL_PASSWORD} --default-character-set=utf8 --routines --events --triggers --master-data=2 --host=${SET_MYSQLD_SLAVE_MASTER_NAME} --databases ${get_databases} | "${mysql[@]}"
						EOSQL
                        chmod +x /docker-entrypoint-initdb.d/aa-pull-master.sh
                    fi
                fi
                ## open semisync by default
                if [ "${MYSQLD_RPL_SEMI_SYNC_SLAVE_ENABLED:-x}" == "x" ];then
                    echo "rpl_semi_sync_slave_enabled = ON" >> ${config_file}
                    echo 'plugin-load="rpl_semi_sync_slave=semisync_slave.so"' >> ${config_file}
                fi
                echo "Starting Slave Server...."
        else
                echo "Starting standalone Server...."
        fi
fi

docker-entrypoint.sh $@