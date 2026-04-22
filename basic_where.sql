select * from emp;
select distinct job from emp;
select job as a from emp;
select * from emp where deptno = 30;
select * from emp where deptno =30 and job = 'SALESMAN';
select * from emp where deptno = 30 or job = 'SALESMAN';
select * from emp where sal >= 3000;
select * from emp where ename >= 'F';
select * from emp where sal !=3000;
select * from emp where sal <>3000;
select * from emp where not sal =3000;
select * from emp where job in ('MANAGER','SALESMAN','CLERK');
select * from emp where sal between 2000 and 3000;

select * from emp where ename like 'S%';
select * from emp where ename like '_L%';
select * from emp where ename like '%AM%';