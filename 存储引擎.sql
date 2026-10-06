# 查询当前数据库支持的存储引擎
show engines;

# 查询建表语句  --- 默认存储引擎: InnoDB
show create table tb_user;

# 创建表 my_myisam , 并指定 MyISAM 存储引擎
create table my_myisam (
    id int,
    name varchar(30)
) engine = myisam;

show create table my_myisam;

# 创建表 my_memory , 并指定 Memory 存储引擎
create table my_memory (
  id int,
  name varchar(30)
) engine = memory;

show create table my_memory;

# 查看 innodb 的参数 - on
show variables like 'innodb_file_per_table'
