#!/bin/bash
function get_mysql_result() {
    file_var=/home/ceph
    project=ceph/ceph
    echo "Now is The Commands Result"
    echo -e '\033[36m=======================\033[0m'
    var=`ls -l $file_var |grep ^d  |awk '{print $9}'`
    count=`ls -l $file_var |grep ^d  |awk '{print $9}'|wc -l`
    echo  -e "====Total Dir Count is $count ===="
    sum=0
    num=0
    for i in $var;
    do
        echo -e  "\033[36mProcess in $i\033[0m"
        #使用let 方法定义一个自增变量
        let num+=1;
        #echo "And MySQL Result is following"
        # 使用awk NR==n 只获取第n行的内容
        sql=`mysql -uroot -proot -D git -e "select count(1) from request_file where project='$project' and file_name like '$i%'" |awk NR==2`
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
echo -e   "\033[36m${var// /$'\n'}\033[0m"
echo -e  "Total Dir File is $sum "
}

get_mysql_result
