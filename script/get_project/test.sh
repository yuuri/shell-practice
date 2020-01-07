#! /bin/bash
for line in `cat project_name.txt|sed 's/\"//g'`;do
	echo "$line"
	action="git clone http://github.com/"${line}
	echo "$action"
    echo `$action`
	#echo -e `git clone http://github.com/${line}.git`
done
