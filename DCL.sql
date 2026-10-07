-- 一、管理用户
-- 查询用户
select * from mysql.user;

-- 其中 Host代表当前用户访问的主机, 如果为localhost, 仅代表只能够在当前本机访问，是不可以
-- 远程访问的。 User代表的是访问该数据库的用户名。在MySQL中需要通过Host和User来唯一标识一
--  个用户。

-- 创建用户
create user 'zhou'@'%' identified by '6666'; -- 可以远程访问
create user 'yq'@'localhost' identified by '6666'; -- 不可以远程访问

-- 修改用户密码
alter user 'zhou'@'%' identified with caching_sha2_password  by '1111';

-- 删除用户
drop user 'yq'@'localhost';

-- 二、权限控制
-- ALL, ALL PRIVILEGES 所有权限
-- SELECT 查询数据
-- INSERT 插入数据
-- UPDATE 修改数据
-- DELETE 删除数据
-- ALTER 修改表
-- DROP 删除数据库/表/视图
-- CREATE 创建数据库/表

-- 查询权限
show grants for 'zhou'@'%'; -- GRANT USAGE ON *.* TO `zhou`@`%` 链接数据库的权限

-- 授予 'zhou'@'%' 用户mysql-study数据库所有表的所有操作权限
grant all on `mysql-study`.* to 'zhou'@'%';

-- 撤销 'zhou'@'%' 用户mysql-study数据库所有表的所有操作权限
revoke all on `mysql-study`.* from 'zhou'@'%';
