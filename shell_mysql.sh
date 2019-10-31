#!/bin/bash
echo "Now is The Commands Result"
echo -e '\033[36m=======================\033[0m'
var=`ls -l /home/pytorch |grep ^d  |awk '{print $9}'`
count=`ls -l /home/pytorch |grep ^d  |awk '{print $9}'|wc -l`
echo  -e "====Total Dir Count is $count ===="
num=0
for i in $var;
do
#echo "Now Dir is $i"
#echo "And MySQL Result is following"
# 使用awk NR==n 只获取第n行的内容
sql=`mysql -uroot -proot -D git -e "select count(1) as $i from request_file where project='pytorch/pytorch' and file_name like '$i%'" |awk NR==2`
# 使用$'\n'在变量中添加换行符
result=$i:$sql$'\n'

array[$num]=$result
#使用let 方法定义一个自增变量
let num+=1;
#echo -e '\033[36m====== result is ======\033[0m'
#echo -e "$sql"
#echo " "
#echo -e '\033[36m======== Done =========\033[0m'
#echo " "
done
#使用${array[@]} 或者 ${array[*]}获得一个变量的所有值
echo -e  "\033[36m${array[@]}\033[0m"
