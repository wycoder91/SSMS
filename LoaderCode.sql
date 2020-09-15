use master
go

create database LoaderCodeDB
on primary
(
	name = 'LoaderCodeDB_data',
	filename = 'F:\DB\LoaderCodeDB_data.mdf',
	size = 300MB,
	filegrowth = 100MB
)
,
(
	name = 'LoaderCodeDB_data1',
	filename = 'F:\DB\LoaderCodeDB_data1.ndf',
	size = 200MB,
	filegrowth = 100MB
)
log on
(
	name = 'LoaderCodeDB_log',
	filename = 'F:\DB\LoaderCodeDB_log.ldf',
	size = 300MB,
	filegrowth = 100MB
)
go

use LoaderCodeDB
go
--存放车型配置，事先存储好，用于逻辑判断，基本做改动，只查询
if exists(select * from sysobjects where name='LoaderConfigrationBase')
drop table LoaderConfigrationBase
go
create table LoaderConfigrationBase
(
	LoaderConfigrationId int identity(1,1) primary key not null,
	productModel nvarchar(20),
	transferMethod nvarchar(20),
	tonnage nvarchar(20),
	wheelbase nvarchar(20),
	special nvarchar(20),
	powerForm nvarchar(20),
	emission nvarchar(20),
	configurationUpgrade nvarchar(20),
	formatNumber nvarchar(20),
	engine nvarchar(20),
	gearbox nvarchar(20),
	boom nvarchar(20),
	bucket nvarchar(20),
	controlMethod nvarchar(20),
	sales nvarchar(20),
	optional nvarchar(100) default(null)
)
go
--存放生成的编码，及对应配置
if exists(select * from sysobjects where name='LoaderCode')
drop table LoaderCode
go
create table LoaderCode
(
	LoaderCodeId int identity(100,1) primary key not null,
	wholeCode nvarchar(18),
	wholeConfigration nvarchar(200)
)
go

use LoaderCodeDB
go
select productModel from LoaderConfigrationBase where LoaderConfigrationId = 1

select * from LoaderCode
select count(*) from LoaderCode
select * from LoaderConfigrationBase
select wholeCode from LoaderCode where LoaderCodeId = 100

delete from LoaderConfigrationBase

insert into LoaderConfigrationBase(productModel,transferMethod,tonnage,wheelbase,special,
powerForm,emission,configurationUpgrade,formatNumber,engine,gearbox,boom,bucket,controlMethod,
sales,optional
)
values
--1
('山推:L','液力传动:A','2吨:2','短轴距:2','无:A','柴油:A','国2:B','无:1','煤炭版:CH','潍柴:W','杭齿双变:H',
'超短臂:S','标准斗:B','非先导双手柄:J','国内:0',null),
--2
('德工:D','机械传动:M','3吨:3','中轴距:3',null,'电池:B','国3:C','2:2','沙漠版:DS','重发:C','山推双变:S',
'标准臂:B','侧卸斗:C','非先导三手柄:S','国外:1',null),
--3
(null,'静液压传动:H','5吨:5','中轴距:5',null,'汽油:G','国4:G','3:3','极寒版:EC','康明斯:K','青州双变:Q',
'加长臂:C','岩石斗:Y','简配先导单手柄:A',null,null),
--4
(null,'电传动:E','6吨:6','长轴距:6',null,'天然气:L','欧4:K','4:4','灵动版:FL','上柴:S','WG180箱:W',
'长臂金刚:J','煤斗:M','简配先导双手柄:B',null,null),
--5
(null,null,'7吨:7','长轴距:8',null,null,null,'5:5','叉装版:FT','道依茨:D','4WG200箱:G',
'超长臂:L','抓木器:Z','简配先导三手柄:C',null,null),
--6
(null,null,'8吨:8','长轴距:9',null,null,null,'6:6','重载版:HD','洛拖:L','YB230:Y',
'特殊臂:T','抓草机:G','卡特先导单手柄:D',null,null),
--7
(null,null,'9吨:9',null,null,null,null,'7:7','高原版:HL',null,'金城双变:J',
null,'简易除雪铲:S','卡特先导双手柄:E',null,null),
--8
(null,null,null,null,null,null,null,'8:8','夹木版:HW',null,null,
null,'货叉:H','卡特先导三手柄:F',null,null),
--9
(null,null,null,null,null,null,null,'9:9','矿石版:MH',null,null,
null,'破碎锤:P','三联液控双手柄:G',null,null),
--10
(null,null,null,null,null,null,null,'10:10','矿井版:MW',null,null,
null,'推土铲:T',null,null,null),
--11
(null,null,null,null,null,null,null,'11:11','沙石版:SG',null,null,
null,'液控除雪铲:R',null,null,null),
--12
(null,null,null,null,null,null,null,'12:12','冰雪版:SI',null,null,
null,'岩石叉:F',null,null,null),
--13
(null,null,null,null,null,null,null,'13:13','侧卸版:SU',null,null,
null,'抱管机:U',null,null,null),
--14
(null,null,null,null,null,null,null,'14:14','牧场版:MC',null,null,
null,null,null,null,null)

insert into LoaderCode(wholeCode,wholeConfigration)
values('LADDSFGSDFG','山推/液力传动/5吨/长轴距/无/柴油/国2/无/煤炭版/潍柴/杭齿双变/超短臂/标准斗/非先导双手柄/国内')