emp2 dept2 테이블을 참고하여,

'AL Pacino'와 "같은 지역"에서
근무하는 직원들의 평균 연봉보다 많이 받는 직원들의 
사번, 이름, 부서번호 / 부서이름, 근무지 / 급여 를 출력하세요.;
---empno, name, deptno(pcode) / d.dname, area / pay
select * from emp2;
select * from dept2;


select e.empno, e.name, e.deptno, d.dname, d.area, e.pay
from emp2 e, dept2 d
where pay > ( select avg(pay)
                from emp2
                where deptno in (
                                select dcode
                                from dept2
                                where area = ( select area
                                                from dept2
                                                where dcode = ( select deptno
                                                                from emp2
                                                                where name = 'AL Pacino')))
)
and e.deptno = d.dcode; 


select *
from emp2
where pay > ( select avg(pay)
                from emp2
                where deptno in (
                                select dcode
                                from dept2
                                where area = ( select area
                                                from dept2
                                                where dcode = ( select deptno
                                                                from emp2
                                                                where name = 'AL Pacino')))
);


















select * from emp2;
select * from dept2;
-------------------

select *
from emp2                 ---deptno = 1000
where name = 'AL Pacino'; ---Seoul Branch Office

select avg(pay)     ---4,310,000
from (select e.name, e.deptno, e.pay
from dept2 d, emp2 e
where area = 'Seoul Branch Office')
;

-----------------------------------------------------
select
from emp2 e
    (
    select avg(pay)     ---4,310,000
    from (select e.name, e.deptno, e.pay
    from dept2 d, emp2 e
    where area = 'Seoul Branch Office')
    ) 
where avg(pay) > 4,310,000
;    
 
select e.name, e.deptno, e.pay
from emp2 e, dept2 d
where d.area = 'Seoul Branch Office';