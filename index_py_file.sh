#!/bin/bash
pytorch=/home/pytorch
now_path=`pwd`
cd $pytorch
echo -e "Run Git Pull...."
git=`git pull`
echo -e "$git"
count=`find /home/pytorch -name "*.py" |wc -l`
file=`find /home/pytorch -name "*.py"| grep -v test`
test_file=`find /home/pytorch -name "*.py" | grep test`
tmp_file=tmp/pytorch_tmp
#action=`mkdir $tmp_file`
#echo -e "$action"
for i in $file
do
	echo -e "$i"
	echo -e "\033[1;34mImport info is following\033[0m"
	#cat $i | grep -w import
	import_count=`cat $i | grep -w import | wc -l`
	echo -e "$import_count"
	#使用awk命令获取最后一个单词
	last_word=`cat $i | grep import |awk '{print $NF}'`
	echo -e "$last_word"
	if [ $import_count == 0 ]
	then 
		echo -e "This File No Import Info"
		let zero_count+=1
	fi
	echo -e " "
	echo -e " "
	let a+=1
	
	array[$a]=$i
	#echo "number is $a"
done
array_var=$array[@]
#echo -e "${var// /$"\n"}"
echo "numer is $a"
echo -e "Zero Count is $zero_count"
echo -e "\033[1;34mTotal Python File Number is $count \033[0m"
