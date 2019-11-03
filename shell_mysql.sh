#!/bin/bash
function get_mysql_result() {
    file_var=/home/ceph
    project=ceph/ceph
    echo "Now is The Commands Result"
    echo -e '\033[1;34m=======================\033[0m'
    var=`ls -l $file_var |grep ^d  |awk '{print $9}'`
    count=`ls -l $file_var |grep ^d  |awk '{print $9}'|wc -l`
    echo  -e "====Total Dir Count is $count ===="
    sum=0
    num=0
    for i in $var;
    do
        echo -e  "\033[1;34mProcess in $i\033[0m"
        #使用let 方法定义一个自增变量
        let num+=1;
        #echo "And MySQL Result is following"
        # 使用awk NR==n 只获取第n行的内容
        sql=`mysql -uroot -proot -D git  -e "select count(1) from request_file where project='$project' and file_name like '$i%'" |awk NR==2`
        # 求和
        let sum+=$sql
        echo "$sql"
        # 使用$'\n'在变量中添加换行符
        #result=i:sql$'\n'
        result=$i:$sql
        array[$num]=$result
        #echo -e '\033[36m====== result is ======\033[0m'
        #echo -e "$sql"
        #echo " "
        #echo -e '\033[36m======== Done =========\033[0m'
        #echo " "
    done
echo "Result is following"
#使用array[@]或者{array[*]}获得一个变量的所有值
var=${array[*]}
# 使用(var///'\n')将默认以空格为分隔符的数组输出转为以换行符为分隔符
echo -e   "\033[1;34m${var// /$'\n'}\033[0m"
echo -e  "Total Dir File is $sum "
#获取数据库中文件总数(相同文件名只统计一次)
sql2=`mysql -uroot -proot -D git -e "select count(distinct file_name) from request_file where project='$project'"|awk NR==2`
echo -e "\033[34m \033[5m"
#颜色序列前加1,表示粗体
echo -e  "查询不同文件保存到本地...."
mkdir -p /tmp/$project
sql3=`mysql -uroot -proot -D git -e "select @num:=@num+1 as 序号,result.file_name as file from (select distinct(a.file_name),a.project from request_file as a where a.project='$project') as result,(select @num:=0) r into outfile '/tmp/$project/distinct_file.csv' fields terminated by ',' optionally enclosed by '\"' lines terminated by '\r\n'"`
echo -e "$sql"
echo " "
}

get_mysql_result
