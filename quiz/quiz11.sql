select * from emp;
--emp 전체 sal 급여 평균
select 
    count(deptno), avg(sal)
from emp;

--emp 30번부서사람들 평균급여
select 
    count(deptno), avg(sal)
from emp
where deptno = 30;


select * from emp;
--emp 각부서별 평균 급여
select deptno, avg(sal)
from emp
group by deptno
order by deptno;


--

select 10, avg(sal)
    from emp
    where deptno = 10
union all    
select 20, avg(sal)
    from emp
    where deptno = 20
union all    
select 30, avg(sal)
    from emp
    where deptno = 30;


--emp 각부서별 인원과 평균 급여
select 
    deptno, count(*) 인원수, avg(sal) 평균급여
from emp
group by deptno
order by deptno;


--emp 각 직업별 평균 급여
select 
    job, avg(sal) 평균급여
from emp
group by job
order by job;

--emp 각 직업별 가장 높은 급여 얼마?
select 
    job, max(sal) 높은급여
from emp
group by job;

--emp 각 부서별 가장 높은 급여 얼마?
select 
    deptno, max(sal) 높은급여
from emp
group by deptno
order by deptno;
