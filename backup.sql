select sum(t.file_count) from (select file_name,count(file_name) as file_count from request_file where project='pytorch/pytorch' group by file_name order by file_count) t;
select count(1) from (select file_name,count(file_name) as file_count from request_file where project='pytorch/pytorch' group by file_name order by file_count) t;

select file_name,count(file_name) as file_count from request_file where project='pytorch/pytorch' group by file_name  having file_count>10;

select count(1) from (select file_name,count(file_name) as file_count from request_file where project='pytorch/pytorch' group by file_name  having file_count>10) t;

select @num:=@num+1,result.* from (select file_name,count(file_name) as file_count from request_file where project='pytorch/pytorch' group by file_name having file_count>10) as result,(select @num:=0) r;
select @num:=@num+1 as count,result.* from (select distinct pull_number,comment_user from comments where project='ceph/ceph' order by pull_number,comment_date) result,(select @num:=0) r limit 10

select count(1) from (select distinct user_login from pull_request where project='ceph/ceph' union select distinct comment_user from comments where project='ceph/ceph') r

select count(distinct pull_number) from comments where project='pytorch/pytorch' and comments.pull_number in (select number from pull_request where request_date between '2018-06-01 00:00:00' and '2019-09-01 00:00:00');

select pull_number,count(file_name) as num from request_file where project='pytorch/pytorch' and pull_number in (select number from pull_request where project='pytorch/pytorch' and request_date between '2018-06-01 00:00:00' and '2019-09-01 00:00:00') group by pull_number order by pull_number limit 10;
/* 使用GROUP_CONCAT 将字段合并，使用ditinct关键字去重*/
set @project='pytorch/pytorch';select pull_number,GROUP_CONCAT(distinct comment_user) from comments where project=@project and pull_number in (select number from pull_request where project=@project and request_date between '2018-06-01 00:00:00' and '2019-09-01 00:00:00') group by pull_number order by pull_number
/* 使用join 查询两个中的两个时间字段，使用timestampdiff函数计算两个时间的差值,函数第一个参数为求时间差的单位 */
select c.pull_number,timestampdiff(hour,p.request_date,c.comment_date) as time from comments as c inner join pull_request p on p.number=c.pull_number  and c.project=@project and p.project=@project and p.request_date between '2018-06-01' and '2019-09-01' group by c.pull_number order by c.pull_number
/* string_index 分割字符串函数; locate 判断字符串是否存在某个字符函数，返回值为存在的个数，如果不存在，结果为0 */
select pull_number,group_concat(distinct substring_index(file_name,'/',2)) from request_file where project='ceph/ceph' and locate('/',file_name)>0 group by pull_number limit 10;
select pull_number,group_concat(distinct substring_index(file_name,'/',1)) from request_file where project=@project and pull_number in (select number from pull_request where project=@project and request_date between '2018-06-01' and '2019-09-01') and locate('/',file_name)>0 group by pull_number limit 10;
/* 查询并导出查询结果为csv文件 */
select @num:=@num+1 as 序号,result.* from (select project,count(distinct user_login) as USER_COUNT,count(1) as PR_COUNT,min(request_date) as START_TIME,max(request_date) as END_TIME from pull_request group by project) result ,(select @num:=0) r into outfile '/var/lib/mysql-files/mysql_20191223.csv' fields terminated by ',' optionally enclosed by '\"' lines terminated by '\r\n';
/* 输出结果与上一条语句一样，差别在于输出表头 */
select * from (select "NO" as NO,"PROJECT" as PROJECT,"USER_COUNT" as COUNT,"PR_COUNT" as PR_COUNT,"START_TIME" as START_TIME,"END_TIME" as END_TIME union all select @num:=@num+1 as NO,result.* from (select project,count(distinct user_login) as USER_COUNT,count(1) as PR_COUNT,min(request_date) as START_TIME,max(request_date) as END_TIME from pull_request group by project) result ,(select @num:=0) r) t into outfile '/var/lib/mysql-files/mysql_20191223_3.csv' fields terminated by ',' optionally enclosed by '\"' lines terminated by '\r\n';

/* 使用 with roll up 进行分组 (用来要求在一条group by子句中进行多个不同的分组) */
set @project='ceph/ceph';select comment_user,group_concat(user_login),group_concat(comment_date) from (select number,user_login from pull_request where project=@project) p inner join (select comment_user,comment_date,pull_number from comments where project=@project) c on p.number=c.pull_number group by comment_user,user_login with rollup limit 100\G;

