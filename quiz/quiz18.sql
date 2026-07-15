--1.
student, department
이름이 'Anthony Hopkins' 인 학생과 1전공(103)이 동일한 학생들의 정보 
(이름, 학과번호, 학과이름) 출력하기.;
--select * from student
--where deptno1 = 103;
--
--select * from student
--where deptno1 = (select deptno1 from student
--                where name = 'Anthony Hopkins')
--order by name;
select * from department;   --dname deptno  dname
select * from student;      --name  deptno1

select
    name,
    deptno1,
    '학과이름',
    d.*
from student s, department d
where deptno1 = (select deptno1 from student
                where name = 'Anthony Hopkins')
and s.deptno1 = d.deptno
order by name;

select
    s.name name,
    s.deptno1 deptno1,
    d.dname dname
from student s, department d
where deptno1 = (select deptno1 from student
                where name = 'Anthony Hopkins')
and s.deptno1 = d.deptno
order by name;





--2.
professor, department 테이블 활용. 이름이 'Meg Ryan' 인 교수보다
나중에 입사한 사람의 이름, 입사일, 학과명 을 출력하세요.
select * from professor;    --name  hiredate deptno
select * from department;   --               deptno


select hiredate
from professor
where name = 'Meg Ryan';    --85/09/18

select *    ---맥라이언보다 늦게입사한 사람들...
from professor
where hiredate > (select hiredate
                    from professor
                    where name = 'Meg Ryan');










select 
    p.name name,
    p.hiredate hiredate,
    d.dname dname
from professor p, department d
where hiredate = (select hiredate from professor
                where hiredate = '85/09/18')
and p.deptno = d.deptno;    ---맥라이언만 조회 ...ㅋ




--3.
select * from student;
student 테이블, 1전공(deptno1)이 201번 학과의 평균 몸무게보다 몸무게가 많이 나가는
학생들의 이름과 몸무게 출력하세요.

select avg(weight) 
from student
where deptno1 = 201;    ---평균 67

select * from student
where weight > (select avg(weight) 
from student
where deptno1 = 201)
;

select name, weight
from student
where weight > (select avg(weight) 
                from student
                where deptno1 = 201)
;



--4.
select * from emp2;
select * from dept2;
--emp2, dept2 테이블을 참고하여,
근무지역이 포항인 모든 사원들의 사번, 이름, 부서번호 출력하기!!
--area                empno   name   e.deptno = d.pdept

select dcode
from dept2
where area = 'Pohang Main Office';

select empno, name, deptno
from emp2
where deptno in (select dcode
                from dept2
                where area = 'Pohang Main Office')
;