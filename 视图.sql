use `mysql-study`;

-- 创建视图
create or replace view stu_v_1 as select id, student_name from student where id <= 10;

-- 查询视图
show create view stu_v_1;

select * from stu_v_1;

select *from stu_v_1 where id < 3;

-- 修改视图
create or replace view stu_v_1 as select id, student_name, major from student where id < 3;

alter view stu_v_1 as select id, student_name, gender from student where id < 3;

-- 删除视图
drop view if exists stu_v_1;

-- 视图插入数据
insert into stu_v_1 values (4, 'tom');

-- 视图更新数据
update stu_v_1 set student_name = '江桥' where id = 1;

-- cascaded
create view v1 as select id, student_name from student where id <= 20;

create view v2 as select id, student_name from v1 where id >= 3 with cascaded check option;

create view v3 as select id, student_name from v2 where id <= 15; -- 会检查v2并且级联检查v1

-- local
drop view if exists v1;
drop view if exists v2;
drop view if exists v3;

create view v1 as select id, student_name from student where id <= 3;

create view v2 as select id, student_name from v1 where id >= 2 with cascaded check option;

create view v3 as select id, student_name from v2 where id <= 10;

