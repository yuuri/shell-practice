

#!/bin/sh
foreachd(){
for file in $1/*
do
# 如果是目录就打印处理，然后继续遍历，递归调用
        if [ -d $file ]
        then
                echo $file
		chown aquarius:aquarius $file #更改文件所有者所在用户组
		chmod 755 $file
                foreachd $file
 
	elif [ -e $file ]
	then
		echo $file
		chown aquarius:aquarius $file
		chmod 664 $file
        fi
done
}
 
# 执行，如果有参数就遍历指定的目录，否则遍历当前目录
if [ $# > 0 ]
then
    foreachd "$1"
else
    foreachd "."
fi
