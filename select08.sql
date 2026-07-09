/*-------------------------------------*/
기타 복수행 함수

집계

--emp 부서와 직업별 평균 급여와 사원수
select
    deptno, job, avg(sal) 평균급여, count(*) 사원수
from emp
group by deptno, job;

--emp 부서별 평균 급여와 사원수
select
    deptno, avg(sal) 평균급여, count(*) 사원수
from emp
group by deptno;

--emp 전체 사원의 평균 급여와 사원수
select avg(sal), count(*)
from emp;


--위 3개의 집계 내역을 하나로 통합
select
    deptno, job, avg(sal) 평균급여, count(*) 사원수
from emp
group by deptno, job
union all
select
    deptno, null, avg(sal) 평균급여, count(*) 사원수   --null로 채움..
from emp
group by deptno
union all
select null, null, avg(sal), count(*)               --null로 채움..
from emp
order by deptno, 2
;


*** rollup 
--말아올리다..?

select
    deptno, job, avg(sal) 평균급여, count(*) 사원수
from emp
group by deptno, job;

select
    deptno, job, avg(sal) 평균급여, count(*) 사원수
from emp
group by rollup(deptno, job);

select
    deptno, job, avg(sal) 평균급여, count(*) 사원수
from emp
--group by rollup(job, deptno);
--group by rollup(deptno, job);
group by rollup( (deptno, job) );


group by rollup(deptno, job)
1) group by deptno, job 그룹화 데이터 집계
2) group by deptno 그룹화 데이터 집계
3) () 그룹화 데이터 집계 -> 전체집계

group by rollup(job, deptno)
group by job, deptno
group by job
()

group by rollup( (deptno, job) )
group by (deptno, job)
()                      --group by 뒤에서부터 없애버려~


--------------------------------------
group by rollup(empno, deptno, job)
1) empno, deptno, job
2) empno, deptno
3) empno
4) ()



group by rollup(empno, (deptno, job))
1) empno, (deptno, job)
2) empno
3) ()



select
    deptno, job, avg(sal) 평균급여, count(*) 사원수
from emp
group by rollup(deptno, job);

---------------
CUBE    
1) deptno, job
2) deptno
3)          job
4) ()



/*------------------------------------------------*/
순위 RANK() OVER(order by 정렬기준대상)
그룹단위 순위 RANK() OVER (partition by 그룹기준 order by 정렬기준대상)



