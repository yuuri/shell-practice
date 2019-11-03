#!/bin/bash
now_path=`pwd`
echo '====Now Path is Following  ===='
echo -e "$now_path"

path_dir_list=`ls -l | grep ^d | awk '{print $9}'`
for i in $path_dir_list
do
	cd $now_path/$i
	pwd
	path=$now_path/$i/
	echo -e "\033[1;34mNow File Dir is Following\033[0m"
	echo -e "\033[1;35m$path\033[0m"
	git_action=`git pull`
	echo "$git_action"
	echo " "
done
echo -e  "\033[1;36mGit Pull is Over\033[0m"

