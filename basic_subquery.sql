/*서브쿼리*/

--1)서브쿼리
select sal from emp
where ename = 'JONES';

select * from emp -- ()안에 서브쿼리문
where sal> (select sal from emp where ename = 'JONES');

--2)단일행 서브쿼리
select E.EMPNO , E.ENAME , E.JOB , E.SAL , D.DEPTNO , D.DNAME , D.LOC
from emp E , dept D -- deptno 기준으로 조인
where E.deptno = D.deptno -- deptno E,D로 조인
and E.deptno = 20 -- > deptno가 20인 직원 선택
and E.sal > (select avg(sal) from emp); -- 평균 급여보다 높은 직원선택

--3)다중행 서브쿼리
-- IN연산자
select * from emp -- > in 연산자로 각 deptno에서 sal 이 가장 큰 사람
where sal IN(select max(sal) from emp group by deptno);

--any , some 연산자
select * from emp --결과가 하나라도 참 일경우 조건식이 참
where sal = any(select max(sal) from emp group by deptno);
--각 부서별 급여가 가장 큰 리스트 (서브쿼리)

--all 연산자
select * from emp -- deptno가 30인 직원중 급여가 가장 작은 직원
where sal < ALL (select sal from emp where deptno = 30);

select * from emp --30번 부서의 모든 직원의 급여목록에서 가장 급여가 큰 직원
where sal > ALL (select sal from emp where deptno = 30);

--EXIT 연산자
select * from emp
where EXISTS(select dname from dept where deptno = 10);

select * from emp --deptno 90이 있으면 전체 출력, 없으면 결과x
where EXISTS(select dname from dept where deptno = 90);

--4)다중열 서브쿼리

--from절에 사용하는 서브쿼리
select E10.empno , E10.ename , E10.deptno , D.dname , D.loc
from (select * from emp where deptno = 10) E10,(select * from dept)D
where E10.deptno = D.deptno;

--with절에 사용하는 서브쿼리
with E10 as (select * from emp where deptno =10),
D as (select * from dept)
select E10.empno , E10.ename , E10.deptno , D.dname , D.loc
from E10,D
where E10.deptno = D.deptno;

--select 절에 사용하는 서브쿼리
select empno , ename , job , sal ,
(select grade from salgrade where E.sal between losal and hisal) AS salgrade ,
deptno ,
(select dname from dept
where E.deptno = dept.deptno) as dname
from emp E;




