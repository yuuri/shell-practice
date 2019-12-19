select sum(t.file_count) from (select file_name,count(file_name) as file_count from request_file where project='pytorch/pytorch' group by file_name order by file_count) t;
select count(1) from (select file_name,count(file_name) as file_count from request_file where project='pytorch/pytorch' group by file_name order by file_count) t;
select file_name,count(file_name) as file_count from request_file where project='pytorch/pytorch' group by file_name  having file_count>10;
select count(1) from (select file_name,count(file_name) as file_count from request_file where project='pytorch/pytorch' group by file_name  having file_count>10) t;
select @num:=@num+1,result.* from (select file_name,count(file_name) as file_count from request_file where project='pytorch/pytorch' group by file_name having file_count>10) as result,(select @num:=0) r;
select @num:=@num+1 as count,result.* from (select distinct pull_number,comment_user from comments where project='ceph/ceph' order by pull_number,comment_date) result,(select @num:=0) r limit 10
select count(1) from (select distinct user_login from pull_request where project='ceph/ceph' union select distinct comment_user from comments where project='ceph/ceph') r
select count(distinct pull_number) from comments where project='pytorch/pytorch' and comments.pull_number in (select number from pull_request where request_date between '2018-06-01 00:00:00' and '2019-09-01 00:00:00');
select pull_number,count(file_name) as num from request_file where project='pytorch/pytorch' and pull_number in (select number from pull_request where project='pytorch/pytorch' and request_date between '2018-06-01 00:00:00' and '2019-09-01 00:00:00') group by pull_number order by pull_number limit 10;
