#! /bin/awk -f
BEGIN {
	FS = ","
	total_file = 0
	total_code = 0
	total_language = 0
}
{
	total_file+=$1
	total_code+=$5
}
END{
	OFS = ","
	#var="echo git config remote.origin.url) | sed "s/http:\/\/github.com\///g""
	print project_name
	print "PROJECT,文件总数,代码行数"
	print total_file,total_code
}

