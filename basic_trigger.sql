/* SET SERVEROUTPUT ON; -- 실행결과(출력) */
 
/*기본 LOOP */
/*DECLARE V_NUM NUMBER :=0;
BEGIN LOOP
DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM) ;
V_NUM := V_NUM +1;
EXIT WHEN V_NUM > 4;
END LOOP;
END; */

/*WHILE LOOP */

/*DECLARE V_NUM NUMBER :=0;
BEGIN WHILE V_NUM <4 LOOP
DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
V_NUM :=V_NUM +1;
END LOOP;
END; */

/* FOR 반복문*/
-- 1
/*
BEGIN FOR i in 0..4 loop
DBMS_OUTPUT.PUT_LINE('현재 I 값 : ' || i);
END LOOP;
END;
*/
-- 2
/*
BEGIN FOR i in REVERSE 0..4 loop
DBMS_OUTPUT.PUT_LINE('현재 I 값 : ' || i);
END LOOP;
END;
*/

/* continue 반복문 */

/*
BEGIN FOR i IN 0..4 LOOP
CONTINUE WHEN MOD(i,2) = 1; --홀수일때 true( 위로 올라감) false -> 아래구문 출력
DBMS_OUTPUT.PUT_LINE('현재 I 값 : ' || i);
END LOOP;
END;
*/

/*파라미터를 사용안하는 프로시저 설정 (처리와는 별개로 먼저 실행)  */
/*
CREATE OR REPLACE PROCEDURE pro_noparam
IS
V_EMPNO NUMBER(4) :=7788;
V_ENAME VARCHAR2(10);
BEGIN
V_ENAME :='SCOTT';
DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO );
DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END; 
*/

/* 실행 부분 */
/*
SET SERVEROUTPUT ON;
EXECUTE pro_noparam;
*/
/*
CREATE OR REPLACE PROCEDURE pro_param_in
(
param1 in NUMBER ,
param2 NUMBER ,
param3 NUMBER :=3,
param4 NUMBER DEFAULT 4)
IS
BEGIN
DBMS_OUTPUT.PUT_LINE('param1 : ' ||param1);
DBMS_OUTPUT.PUT_LINE('param2 : ' ||param2);
DBMS_OUTPUT.PUT_LINE('param3 : ' ||param3);
DBMS_OUTPUT.PUT_LINE('param4 : ' ||param4);
END;
*/
-- EXECUTE pro_param_in(1,2,9,8);
-- EXECUTE pro_param_in(1,2);
-- EXECUTE pro_param_in(1);
-- EXECUTE pro_param_in(param1 => 10, param2 => 20); (1,2가 아니라 3,4에 값을 넣을 수 있음)
/*
CREATE OR REPLACE PROCEDURE pro_param_out (
in_empno IN EMP.EMPNO%TYPE,
out_ename OUT EMP.ENAME%TYPE ,
out_sal OUT EMP.SAL%TYPE )
IS
BEGIN
select ENAME , SAL INTO out_ename,out_sal
from emp
where empno = in_empno;
END pro_param_out; */
/*
SET SERVEROUTPUT ON;
DECLARE
v_ename EMP.ENAME%TYPE;
v_sal EMP.SAL%TYPE;
BEGIN
pro_param_out(7788,v_ename,v_sal);
DBMS_OUTPUT.PUT_LINE('ENAME : ' || v_ename);
DBMS_OUTPUT.PUT_LINE('SAL : ' || v_sal);
END; 
*/
-- SELECT * FROM EMP;
/*
CREATE OR REPLACE PROCEDURE pro_param_inout (
inout_no IN OUT NUMBER )
IS
BEGIN
inout_no := inout_no *2;
END pro_param_inout; */
/*
SET SERVEROUTPUT ON;
DECLARE no NUMBER;
BEGIN
no :=5;
pro_param_inout(no);
DBMS_OUTPUT.PUT_LINE('no : ' || no);
END;*/

--CREATE TABLE EMP_TRG AS
--SELECT * FROM EMP;
/*
CREATE OR REPLACE TRIGGER trg_emp_nodml_weekend
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
IF TO_CHAR(sysdate, 'DY') IN ('토' , '일') THEN
IF INSERTING THEN
raise_application_error(-20000 , '주말 사원 정보 추가 불가');
ELSIF UPDATING THEN
raise_application_error(-20001 , '주말 사원 정보 수정 불가');
ELSIF DELETING THEN
raise_application_error(-20002 , '주말 사원 정보 삭제 불가');
ELSE
raise_application_error(-20003 , '주말 사원 정보 추가 불가');
END IF;
END IF;
END; */
/*
SET SERVEROUTPUT ON;
UPDATE emp_trg SET sal = 3500 where empno = 7788; */
/*
CREATE TABLE EMP_TRG_LOG (
TABLENAME VARCHAR2(10) ,
DML_TYPE VARCHAR2(10) ,
EMPNO NUMBER(4) ,
USER_NAME VARCHAR2(30) ,
CHANGE_DATE DATE);
*/
/*
CREATE OR REPLACE TRIGGER trg_emp_log
AFTER
INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO emp_trg_log
VALUES('EMP_TRG','INSERT', :new.empno , SYS_CONTEXT('USERENV','SESSION_USER'),sysdate);

ELSIF UPDATING THEN
INSERT INTO emp_trg_log
VALUES('EMP_TRG','UPDATE', :old.empno , SYS_CONTEXT('USERENV','SESSION_USER'),sysdate);

ELSIF DELETING THEN
INSERT INTO emp_trg_log
VALUES('EMP_TRG','DELETE', :old.empno , SYS_CONTEXT('USERENV','SESSION_USER'),sysdate);
END IF;
END; */

INSERT INTO EMP_TRG
VALUES(9999, 'TestEmp' , 'CLERK' , 7788, TO_DATE('2018-03-03','YYYY-MM-DD'),1200,null,20);
COMMIT;

SELECT * FROM EMP_TRG;
SELECT * FROM EMP_TRG_LOG;

UPDATE EMP_TRG
SET SAL = 1300
WHERE MGR = 7788;
COMMIT;