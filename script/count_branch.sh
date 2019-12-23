#! /bin/bash
dir=`ls -l ./ |grep ^d  |awk '{print $9}'`
count=`ls -l ./ |grep ^d |awk '{print $9}' | wc -l`
echo "dir count is $count"
path=`pwd`
echo "now path is $path"
for i in $dir;do
	dir_path=$path/$i
	cd $dir_path
	#echo "now path is `pwd`"
	branch_num=`git branch -a |wc -l`
	name=`git config remote.origin.url`
	branch_name=${name:18}
	echo "project_name is $branch_name"
	echo -e "$branch_name,$branch_num" >>$path/branch_count.csv
done
