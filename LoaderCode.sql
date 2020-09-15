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
--��ų������ã����ȴ洢�ã������߼��жϣ��������Ķ���ֻ��ѯ
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
--������ɵı��룬����Ӧ����
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
('ɽ��:L','Һ������:A','2��:2','�����:2','��:A','����:A','��2:B','��:1','ú̿��:CH','Ϋ��:W','����˫��:H',
'���̱�:S','��׼��:B','���ȵ�˫�ֱ�:J','����:0',null),
--2
('�¹�:D','��е����:M','3��:3','�����:3',null,'���:B','��3:C','2:2','ɳĮ��:DS','�ط�:C','ɽ��˫��:S',
'��׼��:B','��ж��:C','���ȵ����ֱ�:S','����:1',null),
--3
(null,'��Һѹ����:H','5��:5','�����:5',null,'����:G','��4:G','3:3','������:EC','����˹:K','����˫��:Q',
'�ӳ���:C','��ʯ��:Y','�����ȵ����ֱ�:A',null,null),
--4
(null,'�紫��:E','6��:6','�����:6',null,'��Ȼ��:L','ŷ4:K','4:4','�鶯��:FL','�ϲ�:S','WG180��:W',
'���۽��:J','ú��:M','�����ȵ�˫�ֱ�:B',null,null),
--5
(null,null,'7��:7','�����:8',null,null,null,'5:5','��װ��:FT','������:D','4WG200��:G',
'������:L','ץľ��:Z','�����ȵ����ֱ�:C',null,null),
--6
(null,null,'8��:8','�����:9',null,null,null,'6:6','���ذ�:HD','����:L','YB230:Y',
'�����:T','ץ�ݻ�:G','�����ȵ����ֱ�:D',null,null),
--7
(null,null,'9��:9',null,null,null,null,'7:7','��ԭ��:HL',null,'���˫��:J',
null,'���׳�ѩ��:S','�����ȵ�˫�ֱ�:E',null,null),
--8
(null,null,null,null,null,null,null,'8:8','��ľ��:HW',null,null,
null,'����:H','�����ȵ����ֱ�:F',null,null),
--9
(null,null,null,null,null,null,null,'9:9','��ʯ��:MH',null,null,
null,'���鴸:P','����Һ��˫�ֱ�:G',null,null),
--10
(null,null,null,null,null,null,null,'10:10','�󾮰�:MW',null,null,
null,'������:T',null,null,null),
--11
(null,null,null,null,null,null,null,'11:11','ɳʯ��:SG',null,null,
null,'Һ�س�ѩ��:R',null,null,null),
--12
(null,null,null,null,null,null,null,'12:12','��ѩ��:SI',null,null,
null,'��ʯ��:F',null,null,null),
--13
(null,null,null,null,null,null,null,'13:13','��ж��:SU',null,null,
null,'���ܻ�:U',null,null,null),
--14
(null,null,null,null,null,null,null,'14:14','������:MC',null,null,
null,null,null,null,null)

insert into LoaderCode(wholeCode,wholeConfigration)
values('LADDSFGSDFG','ɽ��/Һ������/5��/�����/��/����/��2/��/ú̿��/Ϋ��/����˫��/���̱�/��׼��/���ȵ�˫�ֱ�/����')