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
for i in $file
do
	echo -e "$i"
	let a+=1
	array[$a]=$i
	#echo "number is $a"
done
array_var=$array[@]
#echo -e "${var// /$"\n"}"
echo "numer is $a"
echo -e "\033[1;34mTotal Python File Number is $count \033[0m"
