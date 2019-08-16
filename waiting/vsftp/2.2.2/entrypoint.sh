#!/bin/bash


FILEPATH=/etc/vsftpd/vsftpd.conf


function get_internet() {
	local INTERNET_IP=$(curl -sS icanhazip.com)
	local linenum=$(grep -nw "^pasv_address" $FILEPATH | awk -F : '{printf $1}')
	if [ -z $linenum ];then
		{
			echo "" >>$FILEPATH
			echo "pasv_address=$INTERNET_IP" >>$FILEPATH
		}
	else
		{
			sed -i "$linenum d" $FILEPATH 
			sed -i "$linenum i pasv_address=$INTERNET_IP" $FILEPATH
		}
	fi
}

function func1() {
	if [ ! -z $VSFTP_DATA_PORT ];then
		{
			local linenum=$(grep -nw "^ftp_data_port" $FILEPATH | awk -F : '{printf $1}')
			if [ -z $linenum ];then
				{
					echo "ftp_data_port=$VSFTP_DATA_PORT" >>$FILEPATH
				}
			else
				{
					sed -i "$linenum d" $FILEPATH 
					sed -i "$linenum i ftp_data_port=$VSFTP_DATA_PORT" $FILEPATH
				}
			fi
		}
	fi
}

function func2() {
	if [ ! -z $VSFTP_PASV_MIN_PORT ];then
		{
			local linenum=$(grep -nw "^pasv_min_port" $FILEPATH | awk -F : '{printf $1}')
			if [ -z $linenum ];then
				{
					echo "pasv_min_port=$VSFTP_PASV_MIN_PORT" >>$FILEPATH
				}
			else
				{
					sed -i "$linenum d" $FILEPATH 
					sed -i "$linenum i pasv_min_port=$VSFTP_PASV_MIN_PORT" $FILEPATH
				}
			fi
		}
	fi
}

function func3() {
	if [ ! -z $VSFTP_PASV_MAX_PORT ];then
		{
			local linenum=$(grep -nw "^pasv_max_port" $FILEPATH | awk -F : '{printf $1}')
			if [ -z $linenum ];then
				{
					echo "pasv_max_port=$VSFTP_PASV_MAX_PORT" >>$FILEPATH
				}
			else
				{
					sed -i "$linenum d" $FILEPATH 
					sed -i "$linenum i pasv_max_port=$VSFTP_PASV_MAX_PORT" $FILEPATH
				}
			fi
		}
	fi
}

func1
func2
func3
get_internet
vsftpd