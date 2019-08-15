#!/bin/bash
set -e

##>>>数据库需要共享/var/lib/mysql 与 /var/run/mysqld 两个卷，以便innobackupex运行时挂载
##>>>设置数据库连接密码,数据库容器名称，全局备份目录，与增量备份目录

##全局变量设置
password=88888888
container_name=master
backdir=/data/backup/mysql
restoredir=/data/restore/mysql


string_to_timestamp () {
	#将目录格式化为时间戳格式
	left_date=${1%_*}
	right_time=${1#*_}
	right_time=${right_time//-/:}
	echo $(date -d "${left_date} $right_time" +%s)
}

get_maxtime_from_arr () {
	#获取最大一个时间戳的下标
	i=0
	maxTimeStamp=
	maxTimeFile=
	for timeTag in $(echo $@);do
		timeStamp[i]=$(string_to_timestamp $timeTag)
		if [ "${maxTimeStamp:-x}" == "x" ];then
			maxTimeStamp=${timeStamp[i]}
			maxTimeFile=$i
		elif [ ${timeStamp[i]} -gt $maxTimeStamp ]; then
			maxTimeStamp=${timeStamp[i]}
			maxTimeFile=$i
		fi
		i+=1
	done
	echo $maxTimeFile
}

get_last_full () {
	i=0
	for timeFileTag in $(ls $1);do
		if [ -f $1/$timeFileTag/fullbackup.txt ];then
			timeTag[i]=${timeFileTag}
			i+=1
		fi
	done
	getMaxNum=$(get_maxtime_from_arr ${timeTag[*]})
	echo ${timeTag[$getMaxNum]}
}

get_last_back () {
	#找到最新的一个目录，且不是空的或者确认备份成功的文件夹
	i=0
	for timeFileTag in $(ls $1);do
		if [ "$(ls -A $1/$timeTag)" != "" ];then
			timeTag[i]=${timeFileTag}
			i+=1
		fi
	done
	getMaxNum=$(get_maxtime_from_arr ${timeTag[*]})
	echo ${timeTag[$getMaxNum]}
}

get_sort_incres () {
	#根据找到的最后一个全量备份时间搜索出之后的增量文件夹并进行恢复，且排除空的文件夹与没有成功的文件夹
	#获取最后一个全量日志目录，并将目录转换成时间戳
	full_base_dir=$(get_last_full $1)
	full_base_timestamp=$(string_to_timestamp ${full_base_dir})
	i=0
	#将所有大于全量日志时间的增量日志目录查询出来
	for timeTag in $(ls $1);do
		timeStampTag=$(string_to_timestamp ${timeTag})
		if [ "$(ls -A $1/$timeTag)" != "" -a ${timeStampTag} -gt ${full_base_timestamp} ];then
			incres[i]=${timeTag}
			i+=1
		fi
	done

	#将查询出来的增量日志进行时间排序
	j=0
	while true;do
		if [ ${#incres[@]} -eq 0 ];then
			break;
		fi
		getMaxNum=$(get_maxtime_from_arr ${incres[*]})
		sortIncres[j]=${incres[$getMaxNum]}
		unset incres[$getMaxNum]
		incres=(${incres[*]})
		j+=1
	done
	echo ${sortIncres[*]}
}

innobackupex=( docker run -it --rm --volumes-from=${container_name} -v ${backdir}:/backup changel/mysql:tools --defaults-file=/etc/mysql/my.cnf --password=${password} )
innorestorex=( docker run -it --rm -v ${backdir}:/backup -v ${restoredir}:/var/lib/mysql changel/mysql:tools --defaults-file=/etc/mysql/my.cnf )

case $1 in
	--full)
		#完整备份，备份完后并在子目录中记录完整备份文档，以便搜索完整备份信息
		"${innobackupex[@]}" /backup
		touch $backdir/$(get_last_back $backdir)/fullbackup.txt
		;;
	--incre)
		#获取最后一个备份作为基础进行增量备份
		"${innobackupex[@]}" --incremental /backup --incremental-basedir /backup/$(get_last_back $backdir)
		;;
	--restore)
		#从最后一个完整备份开始，并将所有后续的增量备份进行恢复
		arr=($(get_sort_incres $backdir))
		arr_index=$((${#arr[@]}-1))

		if [ ${#arr[@]} -eq 0 ];then
			"${innorestorex[@]}" --apply-log /backup/$(get_last_full $backdir)
		else
			#最开始使用将完整备份进行redo
			"${innorestorex[@]}" --apply-log --redo-only /backup/$(get_last_full $backdir)
			for ((i=${arr_index};i>=0;i--));do
				#如果是最后一个增量则不加redo-log参数
				if [ $i -eq 0 ];then
					"${innorestorex[@]}" --apply-log /backup/$(get_last_full $backdir) --incremental-dir=/backup/${arr[i]}
				else
					"${innorestorex[@]}" --apply-log --redo-only /backup/$(get_last_full $backdir) --incremental-dir=/backup/${arr[i]}
				fi
			done
		fi
		"${innorestorex[@]}" --copy-back /backup/$(get_last_full $backdir)
		;;
	*)
		echo "$0: --full for full backup, --incre for incremental backup, --restore to restore data";;
esac
