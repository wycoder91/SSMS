--在这里可以编写任何操作数据库的源代码

--首先指向要操作的数据库

use master
go

--if exists(select * from sysdatabases where name = 'CourseManageDB') 
--drop database CourseManageDB
--go--go表示一段过程或一段操作的结束，Q：此段代码不可以实现删除数据库功能。

--创建数据库
create database CourseManageDB
on primary
(
	--数据库的逻辑文件名（就是系统用的，必须唯一）
	name = 'CourseManageDB_data',
	--数据库物理文件名(绝对路径)
	filename = 'G:\DB\CourseManageDB_data.mdf',--主数据文件名
	--数据库初始文件大小（根据实际生产需求来定）
	size = 100MB,
	--数据文件增量
	filegrowth = 10MB
)
,
(
	name = 'CourseManageDB_data1',
	filename = 'G:\DB\CourseManageDB_data1.ndf',--次要数据文件名
	size = 100MB,
	filegrowth = 10MB
)
log on
(
	name = 'CourseManageDB_log',
	filename = 'G:\DB\CourseManageDB_log.ldf',--日志文件名
	size = 100MB,
	filegrowth = 10MB
)
go
--在新建数据库中创建表格
use CourseManageDB
go

if exists(select * from sysobjects where name='Teather')
drop table Teather
go
create table Teather
(
	TeatherId int identity(1000,1) primary key,--主键，标识列
	LoginAccount varchar(50) not null,
	LoginPwd varchar(20) check(len(LoginPwd)>=6 and len(LoginPwd)<=18) not null,
	TeatherName varchar(20) not null,
	PhoneNumber char(11) not null,
	NowAddress nvarchar(100) default('地址不详') not null
)
go
if exists(select * from sysobjects where name='CourseCategory')
drop table CourseCategory
go
--课程分类
create table CourseCategory
(
	CategoryId int identity(10,1) primary key,
	CategoryName varchar(20) not null
)
go
if exists(select * from sysobjects where name='Course')
drop table Course
go
--课程信息
create table Course
(
	CourseId int identity(100,1) primary key,
	CourseName varchar(20) not null,
	CourseContent nvarchar(200) not null,
	ClassHour int check(ClassHour>=0) not null,
	Credit int not null,
	CategoryId int references CourseCategory(CategoryId) not null,
	TeatherId int references Teather(TeatherId) not null
)
go

--增加
--其他数据表示可以根据需要自行添加

--可以在后边添加数据表约束，这种方式比较麻烦，暂不去了解
--主键的约束是自带的。
--当使用标识列，主键自动由起始位置增1，不用显式添加了。

--向所建数据表中添加测试数据
use CourseManageDB
go
--insert into Teather(TeatherId,LoginAccount,LoginPwd,TeatherName,PhoneNumber,NowAddress)
--values
--(10001,'xiketang01','123456','常老师','15800000001','山东省01市'),
--(10002,'xiketang02','123456','刘老师','15800000002','山东省02市'),
--(10003,'xiketang03','123456','王老师','15800000003','山东省03市'),
--(10004,'xiketang04','123456','田老师','15800000004','山东省04市')

--使用标识列
insert into Teather(LoginAccount,LoginPwd,TeatherName,PhoneNumber,NowAddress)
values
('xiketang01','123457','常老师','15800000001','山东省01市'),
('xiketang02','123456','刘老师','15800000002','山东省02市')

insert into CourseCategory(CategoryName) values ('.Net开发'),('微信小程序')

insert into Course(CourseName,CourseContent,ClassHour,Credit,CategoryId,TeatherId)
values
('.Net全栈开发课程','常老师C#开发语言课',300,100,10,1000),
('.Net全栈开发课程','常老师软件设计框架',400,100,10,1000),
('.Net全栈开发课程','常老师SQL Server数据库',300,100,11,1001)

--删除
delete from Teather where (TeatherId>1000 and TeatherId<=1011)

--修改
update Teather set LoginAccount='xiketang08',LoginPwd='4567890' where TeatherName='常老师'
--查询
select * from Teather
select * from CourseCategory
select * from Course

--外键关联后，联合查询
select CourseName,CourseContent,ClassHour,Credit,Course.CategoryId,CategoryName from Course
inner join CourseCategory on CourseCategory.CategoryId=Course.CategoryId

--解除外键关联
select
    fk.name,fk.object_id,OBJECT_NAME(fk.parent_object_id) as referenceTableName
from sys.foreign_keys as fk
join sys.objects as o on fk.referenced_object_id=o.object_id
where o.name='Teather'

alter table dbo.Course drop constraint FK__Course__TeatherI__1CBC4616