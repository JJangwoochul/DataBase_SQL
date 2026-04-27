/* 20260423 Database SQL */

/*대소문자 변환*/
select ename , upper(ename) , lower(ename) , initcap(ename)
from emp; 
/*upper -> 대문자 , lower -> 소문자 , initcap -> 첫문자만 대문자*/
select * from emp
where upper(ename) = upper('scott');
/* ename이 upper(대문자)인 scott만 출력*/
select * from emp
where upper(ename) like upper ('%scott%');
/*Length 문자열 길이*/
select ename , length(ename)
from emp; /*ename 의 길이*/

select ename , length(ename)
from emp
where length(ename) >=5; /*ename의 길이가 5이상인것만*/

/*substr 문자열 일부 추출*/
select job from emp;
select job , substr(job,1,2) ,substr(job,3,2),substr(job,5)
from emp; /*각각 job에서 첫번째부터 2글자 , 3번째부터2글자, 5번째부터 그 이후*/

/*instr 문자열 데이터에서 특정 문자위치 찾기*/
select * from emp;
select * from emp
where instr(ename,'S') >0; /*ename에서 s가 들어간사람만 출력*/
/*replace 특정 문자를 다른 문자로 대체*/
select '010-1234-5678' as replace_before , /* 그대로 출력 */
replace('010-1234-5678','-', ' ') as replace_1, /* -을 공백으로 출력 */
replace('010-1234-5678','-') as replace_2 /* -제외 출력 */
from dual;

/*LPAD , RPAD 데이터의 빈 공간 채우기*/
select 'Oracle' ,
LPAD('Oracle',10,'#') as LPAD_1 , /*결과창 빈칸만큼 채우기*/
RPAD('Oracle',10,'*') as LPAD_1 ,
LPAD('Oracle',10) as LPAD_2 , /*빈칸을 공백으로 (왼쪽,오른쪽몰아주기)*/
RPAD('Oracle',10) as LPAD_2
from dual;

/*CONCAT 두 문자열 합치기*/
select concat(empno,ename) , concat(empno, concat(' : ', ename))
from emp /*empno과 ename 합쳐서 작성  , 사이에 : 추가*/
where ename = 'SCOTT';

/*TRIM , LTRIM , RTRIM 특정 문자 지우기*/
select '[' || trim('__Oracle__')|| ']' as trim, 
'[' || trim(LEADING from '__Oracle__')|| ']' as trim_leading,
'[' || trim(TRAILING from '__Oracle__')|| ']' as trim_trailing,
'[' || trim(BOTH from '__Oracle__')|| ']' as trim_both
from dual;

/*round 반올림*/
select
round(1234.5678) as round,
round(1234.5667,0) as round_0,
round(1234.5678,1) as round_1 /*소숫점 자리*/
from dual;

/*trunc 버림*/
select
trunc(1234.5678) as trunc,
trunc(1234.5678,0) as trunc_0,
trunc(1234.5678,1) as trunc_1 /*남기는 소숫점 자리*/ 
from dual;

/*ceil , floor 가까운 큰 정수 , 작은 정수*/
select
ceil(3.14),
ceil(-3.14),
floor(3.14),
floor(-3.14)        /*올림, 내림*/
from dual;

/*mod 나머지*/
select
mod(15,6),
mod(10,2),
mod(11,2)
from dual;

/*sysdate 현재 날짜와 시간*/
select sysdate as NOW,
sysdate -1 as yesterday,
sysdate +1 as tomorrow
from dual;

/*add_months 몇개월 이후의 날짜*/
select sysdate,
add_months(sysdate,3) /*현재 날짜에서 3개월 이후*/
from dual;

SELECT EMPNO, ENAME, HIREDATE,
ADD_MONTHS(HIREDATE, 120) AS WORK10YEAR 
FROM EMP; /*hiredate에서 120개월이후 -> work10year*/

SELECT EMPNO, ENAME, HIREDATE, SYSDATE
FROM EMP 
WHERE ADD_MONTHS(HIREDATE, 384) > SYSDATE;

/*MONTHS_BETWEEN 두 날짜간의 개월수 차이*/
select empno , ename , hiredate , sysdate ,
months_between (hiredate , sysdate) as MONTHS1,
months_between (sysdate , hiredate) as MONTHS2,
trunc(months_between (sysdate, hiredate)) as MONTHS3
from emp;

/*next_day , last_day 돌아오는 요일 , 달의 마지막 날*/
select sysdate,
next_day(sysdate,'월요일'), /*다음주 월요일*/
last_day(sysdate)
from dual;

/*to_char 숫자 , 날짜 데이터를 문자 데이터로 변환 */
select SYSDATE,
to_char (SYSDATE , 'HH24:MI:SS') AS HH24MISS ,
to_char (SYSDATE , 'HH12:MI:SS AM') AS HH12MISS_AM ,
to_char (SYSDATE , 'HH:MI:SS P.M.') AS HHMISS_PM
from dual;

/*NVL null이 아니면 그대로 , null이면 지정한 값*/
select empno , ename , sal , comm , sal+comm , /*null 이 있으면 더해도 null*/
nvl(comm,0), /*null값을 0으로 설정*/
sal+nvl(comm,0) /*더하면 null 이 0으로 바꿔서 값이나옴*/
from emp;

/*NVL2 NULL이 아닐때와 null일때 각각 지정한 값*/
select empno , ename , comm ,
nvl2( comm , 'O' , 'X'),    /*null일땐 x nuu이 아닐땐 O*/
nvl2( comm, sal*12 + comm , sal*12) as ANNSAL /*null이 있어도 계산가능*/
from emp;

/*case 조건*/
select empno , ename , job , sal , 
case job
when 'MANAGER' then sal *1.1
when 'SALESMAN' then sal * 1.05
when 'ANALYST' then sal
else sal * 1.03
end as UPSAL
from emp;

select empno , ename , comm,
case
when comm is null then '해당사항 없음'
when comm = 0 then '수당 없음'
when comm >0 then '수당 : ' ||comm
end as COMM_TEXT
from emp;

/*count 데이터 개수*/
select count(*)
from emp;

select count(*) from emp
where deptno = 30;

select count(distinct sal) ,
count(all sal),
count(sal)
from emp;

select *
from emp , dept
where emp.DEPTNO = dept.DEPTNO
order by empno;

select *
from emp E, dept D
where e.deptno = d.deptno
order by empno;

select e.empno , e.ename , e.sal , d.deptno , d.dname , d.loc
from emp E , dept D
where E.deptno = d.deptno and sal >= 3000;

select * from emp;
select * from dept;

select E1.empno , E1.ename , E1.mgr ,
        E2.empno as MGR_EMPNO ,
        E2.ename as MGR_ENAME
from emp E1, emp E2
where E1.mgr = E2.empno;