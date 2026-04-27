-- 자바랑 연동하는 테이블 , 시퀀스
create table boards (
bno number primary key,
btitle varchar2(100) not null,
bcontent clob not null,
bwriter varchar2(50) not null,
bdate date not null,
bfilename varchar2(50) null,
bfiledate blob null); 

create table users (
userid varchar(50) primary key,
username varchar(50) not null,
userpassword varchar2(50) not null,
userage number(3) not null,
useremail varchar2(50) not null); 

create sequence SEQ_BNO NOCACHE; 