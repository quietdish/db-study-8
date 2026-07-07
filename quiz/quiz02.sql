select * from emp;

/* 1. */
select *
from emp
order by ename;

/* 2. */
select *
from emp
order by deptno, sal desc;

--select *
--from emp
--where sal > 2000;

/* 3. */
select *
from emp
where sal > 2000
order by sal desc;

select * from student;

/* 4. */
select * 
from student
where grade <> 1
order by birthday desc;
