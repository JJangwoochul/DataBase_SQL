--MEMBER테이블
--회원정보 저장 테이블

CREATE TABLE MEMBER (
    memberid    VARCHAR2(50) PRIMARY KEY,   --ID
    password    VARCHAR2(50) NOT NULL,      --비밀번호
    name        VARCHAR2(20) NOT NULL,      --이름
    phone       VARCHAR2(20),               --연락처
    joindate    DATE DEFAULT SYSDATE,       --가입일
    suspended   CHAR(1) DEFAULT 'N',        --정지여부 (N이면 정지X ,Y면 정지상태)
    role        VARCHAR2(10) DEFAULT 'USER' --권한(USER->일반유저,ADMIN->관리자)
);

--BOOK 테이블
--도서 정보 저장 테이블
CREATE TABLE BOOK (
    bookno      NUMBER PRIMARY KEY,     --도서번호
    isbn        VARCHAR2(13),           --도서번호(13자리번호 , - 있어서 문자열)
    bookname    VARCHAR2(50) NOT NULL,  --도서이름
    author      VARCHAR2(50),           --저자
    publisher   VARCHAR2(50),           --출판사
    available   CHAR(1) DEFAULT 'Y'     --대여가능여부 (Y 가능 , N 불가능)
);

--RENTAL 테이블
--도서 대여내역 저장 테이블
CREATE TABLE RENTAL (
    rentno       NUMBER PRIMARY KEY,        --대여번호
    memberid     VARCHAR2(50) NOT NULL,     --회원ID(FK)
    bookno       NUMBER NOT NULL,           --대여한도서번호(FK)
    rentdate     DATE DEFAULT SYSDATE,      --대여일
    duedate      DATE,                      --반납예정일
    returndate   DATE,                      --반납한 날짜
    overdue      CHAR(1) DEFAULT 'N',       --연체여부 (N이면 연체X ,Y면 연체상태)
--FK 
    CONSTRAINT fk_rental_member
        FOREIGN KEY (memberid)
        REFERENCES MEMBER(memberid),

    CONSTRAINT fk_rental_book
        FOREIGN KEY (bookno)
        REFERENCES BOOK(bookno)
);
--BOOK 시퀀스
--도서 번호 자동증가
CREATE SEQUENCE BOOK_SEQ
START WITH 1
INCREMENT BY 1;
-- RENTAL 시퀀스
--대여번호 자동증가
CREATE SEQUENCE RENTAL_SEQ
START WITH 1
INCREMENT BY 1;
 
 /* 테스트용 데이터 
--(확인용) MEMBER
INSERT INTO MEMBER (memberid, password, name, phone, role)
VALUES ('admin', '1234', '관리자', '010-0000-0000', 'ADMIN');

INSERT INTO MEMBER (memberid, password, name, phone)
VALUES ('woo', '1234', '장우성', '010-9284-6869');

--(확인용) BOOK
INSERT INTO BOOK (bookno, isbn, bookname, author, publisher, available)
VALUES (BOOK_SEQ.NEXTVAL, '1231231231234', '안녕', '장우철', '장가', 'Y');

INSERT INTO BOOK (bookno, isbn, bookname, author, publisher, available)
VALUES (BOOK_SEQ.NEXTVAL, '1231231231235', '하세요', '우성장', '장씨', 'Y'); 
*/
/*
-- Database 작동 확인용 코드
select * from member;

select memberid , name , role , suspended
from member
where memberid = 'woo' and password = '1234';

select * from book;

select bookno , bookname , author , publisher , available
from book
where bookname like '%녕%'
or author like '%철%'
or publisher like '%씨%';

select * from rental; */

--프로시저 생성
CREATE OR REPLACE PROCEDURE rent_book_proc(
p_memberid IN VARCHAR2,
p_bookno IN NUMBER)
IS
v_count NUMBER;
BEGIN
--1 대여 가능여부 확인
SELECT COUNT(*) INTO v_count
FROM BOOK
WHERE bookno = p_bookno AND available = 'Y';

IF v_count = 0 THEN
RAISE_APPLICATION_ERROR(-20001, '대여 불가능한 도서.');
END IF;
--2 대여 INSERT
INSERT INTO RENTAL (rentno, memberid, bookno, duedate)
VALUES (RENTAL_SEQ.NEXTVAL, p_memberid, p_bookno, SYSDATE +7);
--3 도서 상태변경
UPDATE BOOK
SET available = 'N'
WHERE bookno = p_bookno;
COMMIT;
END; 