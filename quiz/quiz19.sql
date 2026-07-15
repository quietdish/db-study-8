1.
emp2 테이블 활용                     ---49,000,000
직원 중 'Section head' 직급(position) 최소 연봉자 보다 연봉이
높은 사람의 이름, 직급, 연봉을 출력하기. 
---       name  position    pay
select * from emp2;

select * 
from emp2
where position = 'Section head'
;

select pay
from emp2
where position = 'Section head'
order by pay
;

select *
from (
select pay
from emp2
where position = 'Section head'
order by pay)
where rownum = 1
;


select * 
from emp2
where pay > 최소연봉자의연봉
;

select * 
from emp2
where pay > (select min(pay)
from emp2
where position = 'Section head')
;

select name, position, pay 
from emp2
where pay > (select min(pay)
from emp2
where position = 'Section head')
order by position                       ---정렬 다른뒤??
;

--select
--    position, max(pay)
--    from emp2
--group by position
--;





2.
Student 테이블.
전체 학생중에서 체중이 2학년 학생들의 체중에서 가장 적게 나가는 학생보다
몸무게가 더 적은 학생의 이름, 학년, 몸무게 출력
--              name    grade   weight
select * from student
where grade = 2;

select min(weight)  ---51kg
from student
where grade = 2;

select * 
from student
where weight < (select min(weight)  ---51kg
from student
where grade = 2)
order by weight
;

select name, grade, weight
from student
where weight < (select min(weight)  ---51kg
from student
where grade = 2)
order by weight
;



3.
emp2, dept2 활용
각 부서별 평균연봉을 구하고, 그 중에서 가장 작은 평균 연봉보다도 더 적게
받는 직원들의 부서명, 직원명, 연봉 출력
--          deptno  name    pay
--          pdept   
select * from emp2;
select * from dept2;

select deptno, avg(pay)     ---13개
from emp2
group by deptno;

부서별 평균 연봉
select deptno, avg(pay) --, count(*)     ---13개
from emp2
group by deptno;

여기서 제일 작은 연봉
select *
from (
select deptno, avg(pay) avg_pay     ---13개
from emp2
group by deptno
order by avg_pay
)
where rownum = 1;
;

select avg_pay
from (
select deptno, avg(pay) avg_pay     ---13개
from emp2
group by deptno
order by avg_pay
)
where rownum = 1;
;

그거보다도 적게 받는 직원
select *
from emp2
where pay < (연봉);



select *
from emp2 e, dept2 d
where pay < (select MIN(avg_pay)
from (
select deptno, avg(pay) avg_pay     ---13개
from emp2
group by deptno
))
and e.deptno = d.dcode;


---부서명, 직원명, 연봉 출력
select d.dname, e.name, e.pay
from emp2 e, dept2 d
where pay < (select MIN(avg_pay)
from (
select deptno, avg(pay) avg_pay     ---13개
from emp2
group by deptno
))
and e.deptno = d.dcode;
