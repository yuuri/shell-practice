#!/bin/bash
pytorch=/home/pytorch
now_path=`pwd`
cd $pytorch
echo -e "Run Git Pull...."
git=`git pull`
echo -e "$git"
count=`find /home/pytorch -name "*.py" |wc -l`
file=`find /home/pytorch -name "*.py"`
a=0
for i in $file
do
	let a+=1
	echo "number is $a"
done
echo -e "\033[1;34mTotal Python File Number is $count \033[0m"
