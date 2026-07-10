select * from emp;
--1. emp 테이블에서 평균 급여가 2000 이상인 부서의 부서번호와 평균급여를 구하세요.
select
    deptno 부서번호, avg(sal) 평균급여  --TRUNC(AVG(Sal))
from emp
group by deptno
having avg(sal) >= 2000;

--where sal >2000;  사전에 2000이상인 데이터만 남기겠다..

----------------------ㄴㄴ
select 
    deptno 부서번호,
    avg(sal) 평균급여
from emp
group by deptno, sal
having sal > 2000;


select * from panmae;
--2. panmae 테이블
--각 판매일자 별 총 판매한 수량과 총 판매한 금액을 출력하세요.
select 
    p_date 판매일자,
    sum(p_qty) 판매수량,
    sum(p_total) 판매금액
from panmae
group by p_date
order by p_date;


---------------------ㄴㄴ
select 
    p_date 판매일자,
    p_qty 판매수량,
    p_total 판매금액
from panmae;
group by p_date;
--having 


select * from panmae;
--3. panmae 테이블
--판매일자 기준으로 각 상품코드당 총 판매수량과 총 판매금액을 보여주세요.
--판매일자 기준으로 모든 상품의 판매수량과 판매금액의 소계를 출력하고,
--마지막에 전체 판매수량과 판매금액의 합계도 보여주세요.
select
    p_date 판매일자,
    p_code 상품코드,
    sum(p_qty) 판매수량,
    sum(p_total) 판매금액
from panmae
group by rollup(p_date, p_code);


------------------------------------------
group by rollup(empno, deptno, job)
1) empno, deptno, job
2) empno, deptno
3) empno
4) ()

