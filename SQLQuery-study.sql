--��������Ա�д�κβ������ݿ��Դ����

--����ָ��Ҫ���������ݿ�

use master
go

--if exists(select * from sysdatabases where name = 'CourseManageDB') 
--drop database CourseManageDB
--go--go��ʾһ�ι��̻�һ�β����Ľ�����Q���˶δ��벻����ʵ��ɾ�����ݿ⹦�ܡ�

--�������ݿ�
create database CourseManageDB
on primary
(
	--���ݿ���߼��ļ���������ϵͳ�õģ�����Ψһ��
	name = 'CourseManageDB_data',
	--���ݿ������ļ���(����·��)
	filename = 'G:\DB\CourseManageDB_data.mdf',--�������ļ���
	--���ݿ��ʼ�ļ���С������ʵ����������������
	size = 100MB,
	--�����ļ�����
	filegrowth = 10MB
)
,
(
	name = 'CourseManageDB_data1',
	filename = 'G:\DB\CourseManageDB_data1.ndf',--��Ҫ�����ļ���
	size = 100MB,
	filegrowth = 10MB
)
log on
(
	name = 'CourseManageDB_log',
	filename = 'G:\DB\CourseManageDB_log.ldf',--��־�ļ���
	size = 100MB,
	filegrowth = 10MB
)
go
--���½����ݿ��д������
use CourseManageDB
go

if exists(select * from sysobjects where name='Teather')
drop table Teather
go
create table Teather
(
	TeatherId int identity(1000,1) primary key,--��������ʶ��
	LoginAccount varchar(50) not null,
	LoginPwd varchar(20) check(len(LoginPwd)>=6 and len(LoginPwd)<=18) not null,
	TeatherName varchar(20) not null,
	PhoneNumber char(11) not null,
	NowAddress nvarchar(100) default('��ַ����') not null
)
go
if exists(select * from sysobjects where name='CourseCategory')
drop table CourseCategory
go
--�γ̷���
create table CourseCategory
(
	CategoryId int identity(10,1) primary key,
	CategoryName varchar(20) not null
)
go
if exists(select * from sysobjects where name='Course')
drop table Course
go
--�γ���Ϣ
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

--����
--�������ݱ�ʾ���Ը�����Ҫ�������

--�����ں��������ݱ�Լ�������ַ�ʽ�Ƚ��鷳���ݲ�ȥ�˽�
--������Լ�����Դ��ġ�
--��ʹ�ñ�ʶ�У������Զ�����ʼλ����1��������ʽ����ˡ�

--���������ݱ�����Ӳ�������
use CourseManageDB
go
--insert into Teather(TeatherId,LoginAccount,LoginPwd,TeatherName,PhoneNumber,NowAddress)
--values
--(10001,'xiketang01','123456','����ʦ','15800000001','ɽ��ʡ01��'),
--(10002,'xiketang02','123456','����ʦ','15800000002','ɽ��ʡ02��'),
--(10003,'xiketang03','123456','����ʦ','15800000003','ɽ��ʡ03��'),
--(10004,'xiketang04','123456','����ʦ','15800000004','ɽ��ʡ04��')

--ʹ�ñ�ʶ��
insert into Teather(LoginAccount,LoginPwd,TeatherName,PhoneNumber,NowAddress)
values
('xiketang01','123457','����ʦ','15800000001','ɽ��ʡ01��'),
('xiketang02','123456','����ʦ','15800000002','ɽ��ʡ02��')

insert into CourseCategory(CategoryName) values ('.Net����'),('΢��С����')

insert into Course(CourseName,CourseContent,ClassHour,Credit,CategoryId,TeatherId)
values
('.Netȫջ�����γ�','����ʦC#�������Կ�',300,100,10,1000),
('.Netȫջ�����γ�','����ʦ�����ƿ��',400,100,10,1000),
('.Netȫջ�����γ�','����ʦSQL Server���ݿ�',300,100,11,1001)

--ɾ��
delete from Teather where (TeatherId>1000 and TeatherId<=1011)

--�޸�
update Teather set LoginAccount='xiketang08',LoginPwd='4567890' where TeatherName='����ʦ'
--��ѯ
select * from Teather
select * from CourseCategory
select * from Course

--������������ϲ�ѯ
select CourseName,CourseContent,ClassHour,Credit,Course.CategoryId,CategoryName from Course
inner join CourseCategory on CourseCategory.CategoryId=Course.CategoryId

--����������
select
    fk.name,fk.object_id,OBJECT_NAME(fk.parent_object_id) as referenceTableName
from sys.foreign_keys as fk
join sys.objects as o on fk.referenced_object_id=o.object_id
where o.name='Teather'

alter table dbo.Course drop constraint FK__Course__TeatherI__1CBC4616