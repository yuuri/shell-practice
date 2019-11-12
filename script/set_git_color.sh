#!/bin/bash
pwd=`pwd`
dir=`ls -l | grep ^d |awk '{print $9}'`
#echo -e "$dir"
for i in $dir
do
    echo "$i"
    echo -e "===="
    echo -e "now `pwd`"
    cd $pwd/$i
    echo -e "==== pwd is `pwd`"
    git=`git config color.ui true`
    echo -e "$git"
    cd $pwd
done
