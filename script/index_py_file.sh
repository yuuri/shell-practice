#!/bin/bash
pytorch=/home/pytorch
now_path=`pwd`
cd $pytorch
echo -e "Run Git Pull...."
git=`git pull`
echo -e "$git"
count=`find /home/pytorch -name "*.py" |wc -l`
file=`find /home/pytorch/ -name "*.h" -o -name "*.cc" -o -name "*.cpp" -o -name "*.cu" -o -name "*.py" -o -name "*.mm" -o -name "*.m"`
test_file=`find /home/pytorch -name "*.py" | grep test`
tmp_file=tmp/pytorch_tmp
key=include
#action=`mkdir $tmp_file`
#echo -e "$action"
a=0
for i in $file
do
	echo -e "$i"
	echo -e "\033[1;34mImport info is following\033[0m"
	#cat $i | grep -w import
	extension=${i##*.}
	if [ $extension == py ]
	then
		
		import_count=`cat $i | grep -w import | wc -l`
		echo -e "$import_count"
		#使用awk命令获取最后一个单词
		last_word=`cat $i | grep -w import |awk '{print $NF}'|tr '\n' ' '`
		echo -e "$last_word"
	else
		
		import_count=`cat $i | grep -w $key | wc -l`
		echo -e "$import_count"
		#使用awk命令获取最后一个单词
		last_word=`cat $i | grep -w $key |awk '{print $NF}'|tr '\n' ' '`
		echo -e "$last_word"
	fi
	if [ $import_count == 0 ]
	then 
		echo -e "This File No Import Info"
		let zero_count+=1
	fi
	echo -e " "
	import[$a]=$last_word
	array[$a]=$i
	echo -e " "
	let a+=1
	
	#echo "number is $a"
done
array_var="${array[*]}"
import_var="${import[*]}"
#echo -e "${array_var// /$"\n"}" >>1.txt
#echo -e "${import_var// /$"\n"}">>2.txt
# 获取数组长度
num=${#array[@]} 
echo -e  "!!!!!Total Num is $num"
for ((i=0;i<num;i++))
{
	echo -e "${array[i]},${import[i]}" >>result_c.csv
}
echo "numer is $a"
echo -e "Zero Count is $zero_count"
echo -e "\033[1;34mTotal Python File Number is $count \033[0m"

