-- 一、字符串函数
-- CONCAT(S1,S2,...Sn) 字符串拼接，将S1，S2，... Sn拼接成一个字符串
select concat('hello', ' MySql');

-- LOWER(str) 将字符串str全部转为小写
select lower('MYSQL');

-- UPPER(str) 将字符串str全部转为大写
select upper('hello');

-- LPAD(str,n,pad)左填充，用字符串pad对str的左边进行填充，达到n个字符串长度
select lpad('01', 5, '-');

-- RPAD(str,n,pad)右填充，用字符串pad对str的右边进行填充，达到n个字符串长度
select rpad('01', 5, '-');

-- TRIM(str) 去掉字符串头部和尾部的空格
select trim('  hello mysql  ');
-- 中间的空格不会被去掉

-- SUBSTRING(str,start,len) 返回从字符串str从start位置起的len个长度的字符串
select substring('hellomysql', 1, 5);
-- 索引是从1开始的

-- 案例：由于业务需求变更，企业员工的工号，统一为5位数，目前不足5位数的全部在前面补0。比如： 1号员工的工号应该为00001。
update employee
set workno=lpad(workno, 5, '0');

-- 二、数值函数
-- CEIL(x) 向上取整
select ceil(1.1);
select ceil(1.9);

-- FLOOR(x) 向下取整
select floor(1.9);
select floor(1.1);

-- MOD(x,y) 返回x/y的模
select mod(3, 4);
select mod(6, 5);

-- RAND() 返回0~1内的随机数
select rand();

-- ROUND(x,y) 求参数x的四舍五入的值，保留y位小数
select round(3.1415926, 2);
select round(3.1415926, 3);

-- 案例：
-- 通过数据库的函数，生成一个六位数的随机验证码。
-- 思路： 获取随机数可以通过rand()函数，但是获取出来的随机数是在0-1之间的，所以可以在其基础
-- 上乘以1000000，然后舍弃小数部分，如果长度不足6位，补0
-- select rand() * 1000000;
-- select round(rand() * 1000000, 0);
select lpad(round(rand() * 1000000, 0), 6, '0');

-- 三、日期函数
-- CURDATE() 返回当前日期
select curdate();

-- CURTIME() 返回当前时间
select curtime();

-- NOW() 返回当前日期和时间
select now();

-- YEAR(date) 获取指定date的年份
select year(curdate());

-- MONTH(date) 获取指定date的月份
select month(curdate());

-- DAY(date) 获取指定date的日期
select day(curdate());

-- DATE_ADD(date, INTERVAL expr type)返回一个日期/时间值加上一个时间间隔expr后的时间值
select date_add(now(), interval 70 year);

-- DATEDIFF(date1,date2)返回起始时间date1 和 结束时间date2之间的天数
select datediff('2026-10-08', '2025-09-01'); -- 402
select datediff('2025-09-01', '2026-10-08');-- -402

-- 建表
DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
    id INT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    workno varchar(20) NOT NULL COMMENT '工号',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    gender CHAR(2) DEFAULT NULL COMMENT '性别',
    age INT DEFAULT NULL COMMENT '年龄',
    idcard VARCHAR(18) DEFAULT NULL COMMENT '身份证号',
    workaddress VARCHAR(50) DEFAULT NULL COMMENT '工作地址',
    entrydate DATE DEFAULT NULL COMMENT '入职时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工信息表';

-- 插入数据
INSERT INTO employee (id, workno, name, gender, age, idcard, workaddress, entrydate) VALUES
(1, 1, '柳岩', '女', 20, '123456789012345678', '北京', '2000-01-01'),
(2, 2, '张无忌', '男', 18, '123456789012345670', '北京', '2005-09-01'),
(3, 3, '韦一笑', '男', 38, '123456789712345670', '上海', '2005-08-01'),
(4, 4, '赵敏', '女', 18, '123456757123845670', '北京', '2009-12-01'),
(5, 5, '小昭', '女', 16, '123456769012345678', '上海', '2007-07-01'),
(6, 6, '杨逍', '男', 28, '12345678931234567X', '北京', '2006-01-01'),
(7, 7, '范瑶', '男', 40, '123456789212345670', '北京', '2005-05-01'),
(8, 8, '黛绮丝', '女', 38, '123456157123645670', '天津', '2015-05-01'),
(9, 9, '范凉凉', '女', 45, '123156789012345678', '北京', '2010-04-01'),
(10, 10, '陈友谅', '男', 53, '123456789012345670', '上海', '2011-01-01'),
(11, 11, '张士诚', '男', 55, '123567897123465670', '江苏', '2015-05-01'),
(12, 12, '常遇春', '男', 32, '123446757152345670', '北京', '2004-02-01'),
(13, 13, '张三丰', '男', 88, '123656789012345678', '江苏', '2020-11-01'),
(14, 14, '灭绝', '女', 65, '123456719012345670', '西安', '2019-05-01'),
(15, 15, '胡青牛', '男', 70, '12345674971234567X', '西安', '2018-04-01'),
(16, 16, '周芷若', '女', 18, NULL, '北京', '2012-06-01');

-- 案例：查询所有员工的入职天数，并根据入职天数倒序排序。
-- 思路： 入职天数，就是通过当前日期 - 入职日期，所以需要使用datediff函数来完成。
select name, datediff(curdate(), entrydate) as 'entrydays'
from employee
order by entrydays desc;

-- 四、流程函数
-- IF(value , t , f)如果value为true，则返回t，否则返回f
select if(true, 1, 2);
select if(false, 1, 2);

-- IFNULL(value1 , value2)如果value1不为空，返回value1，否则返回value2
select ifnull('100', '200'); -- 100
select ifnull('', '200'); -- 返回空串
select ifnull(null, '200');
-- 200

-- CASE [ expr ] WHEN [ val1 ] THEN
-- [res1] ... ELSE [ default ] END
-- 如果expr的值等于val1，返回
-- res1，... 否则返回default默认值

-- 需求: 查询emp表的员工姓名和工作地址 (北京/上海 ----> 一线城市 , 其他 ----> 二线城市)
select name, (case workaddress when '北京' then '一线城市' when '上海' then '一线城市' else '二线城市' end)
as '工作地址'
from employee;

-- 建表插入数据
create table score(
id int comment 'ID',
name varchar(20) comment '姓名',
math int comment '数学',
english int comment '英语',
chinese int comment '语文'
) comment '学员成绩表';
insert into score(id, name, math, english, chinese) VALUES (1, 'Tom', 67, 88, 95
), (2, 'Rose' , 23, 66, 90),(3, 'Jack', 56, 98, 76);

-- CASE WHEN [ val1 ] THEN [res1] ...
-- ELSE [ default ] END
-- 如果val1为true，返回res1，... 否
-- 则返回default默认值

-- 案例：数据库中，存储的是学生的分数值，如98、75，如何快速判定分数的等级呢
select id, name, (case when math >= 90 then '优秀' when math >= 60 then '及格' else '不及格' end) 数学,
(case when english >= 90 then '优秀' when english >= 60 then '及格' else '不及格' end) 英语,
(case when chinese >= 90 then '优秀' when chinese >= 60 then '及格' else '不及格' end) 语文
from score;


