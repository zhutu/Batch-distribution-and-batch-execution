##########################################################
# File Name :remote shell scripts
# Author :zhutu
# Created Time :20170531
##########################################################
#!/bin/bash
transfor()
{
	cat $list_file | while read line
	do
		echo "#############################################################"	
		host_ip=`echo $line | awk '{print $1}'`
		echo "The remote server IP:$host_ip"
		username=`echo $line | awk '{print $2}'`
		echo "The user of remote server:$username"
		password=`echo $line | awk '{print $3}'`
		./bin/expect_scp $host_ip $username $password $src_file $dest_file
		echo "#############################################################"	
	done 
}
remoteshell()
{
	
	echo -n "Please input the command you want to remote execute (eg: sh /home/leofs/install.sh ):"	
	echo ""
	read command
	echo "#############################################################"	
	cat $list_file |while read line
	do
		host_ip=`echo $line | awk '{print $1}'`
		echo "The user of remote server:$username"
        	username=`echo $line | awk '{print $2}'`
		echo "The user of remote server:$username"
        	password=`echo $line | awk '{print $3}'`
        	echo "$host_ip"
        	./bin/zhixing $host_ip $username $password $command
		echo "#############################################################"	
	done
}
get_src_file()
{
	echo -n "Please input the scouce file (eg:/home/client/Leo-rd.gz):"
	echo ""
	read var
	src_file=$var
}
get_target_file()
{
        echo -n "Please input the target path  (eg:/home/client/):"
        echo ""
        read var
        dest_file=$var
}
get_lsit_file()
{
	path=`pwd`
	list_file=$path/conf/list_file
}
#get source file and target file and list_file
#chose the remote mode 
echo -n "Do you want to transfer data or Remote execution command,Pleas input 1(means Transfer data ) or 2(means remote execution):"
read  var
if [ "$var" != "1" -a "$var" != "2" ];then
	z=0
	while [ $z -le 3 ]
	do 
		if [ $z -eq 3 ];then
			echo "Too many input failuers,exit......"
			exit 1
		fi
		echo -n "Please type '1'or '2':"
		read var 
		if [ "$var" == "1" -o "$var" == "2" ];then
		break
		fi
		z=$[ $z+1 ]
	done
fi 
if [ "$var" == "1" ];then
	get_src_file
	get_target_file
	get_lsit_file
	echo "$src_file"
	echo "$dest_file"
	echo "$list_file"
	transfor
	else
	if [ "$var" == "2" ];then	
	get_lsit_file
	remoteshell
	fi
fi
