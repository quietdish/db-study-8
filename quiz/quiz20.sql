1. professor 테이블과 department 테이블을 조회하여 **각 학과별**로 입사일이 
가장 오래된 교수의 교수번호와 이름, 학과명을 출력하세요
---hiredate      profno   name  deptno
---(입사일 순으로 오름차순 정렬);
select * from professor;    ---80/06/23
select * from department;
--- p.deptno = d.deptno

select 
    p.profno,
    p.name,
    d.dname,
    p.hiredate                  ---추가..!
from professor p
join department d
on p.deptno = d.deptno
--where p.hiredate in (         ---가장 오래된 날짜들만 찾음
--    select min(hiredate)      ---그 날짜 가진 교수 찾음
--    from professor
--    group by deptno
--    )
join (
    select deptno, min(hiredate) hiredate
    from professor              ---학과별 가장 오래된 날짜 찾음
    group by deptno             ---학과 + 날짜로 교수와 연결
    ) m                         ---정확한 교수 찾음
on p.deptno = m.deptno
and p.hiredate = m.hiredate
order by p.hiredate;



--select * 
--from professor                  ---Computer Engineering
--where hiredate = '80/06/23';    ---1001 Audie Murphy 101

--select 
--    p.profno,
--    p.name,
--    d.dname
--from professor p, department d
--where hiredate = '80/06/23';

select 
    profno,
    name,
    deptno,
    hiredate,
    rank() over (partition by deptno order by hiredate) rank
from professor;


select *
from (
    select 
        profno,
        name,
        deptno,
        hiredate,
        rank() over (partition by deptno order by hiredate) rank
    from professor
)
where rank = 1
;

2. emp2 테이블 조회하여 직급별로 해당 직급에서 최대 연봉을 받는 직원의 
이름과 직급, 연봉을 출력하세요 (연봉순으로 오름차순 정렬);
--name  position    pay
select * from emp2;

select position, max(pay)
from emp2
group by position;

select name, position, pay
from emp2
where (position, pay) in (select position, max(pay)
from emp2
group by position )
order by pay
;