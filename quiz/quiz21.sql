1.
student, department 테이블 활용
학과 이름, 학과별 최대키, 학과별 최대키를 가진 학생들의 이름과 키를 출력 하세요.;
---d.dname
select * from student;
select * from department;


select deptno1, max(height)
from student
group by deptno1;

select *
from student s
where (s.deptno1, s.height) in (select deptno1, max(height)
from student
group by deptno1)
;

select d.dname, s.height max_height, s.name, s.height
from student s, department d
where (s.deptno1, s.height) in (select deptno1, max(height)
from student
group by deptno1)
and s.deptno1 = d.deptno;

--select deptno1, max(height)
--from student
--group by deptno1

select *
from
(select deptno1, max(height) max_height
from student
group by deptno1) A, student B, department C
where A.deptno1 = B.deptno1
and A.max_height = B.height
and A.deptno1 = C.deptno;

select C.dname, A.max_height, B.name, B.height
from
(select deptno1, max(height) max_height
from student
group by deptno1) A, student B, department C
where A.deptno1 = B.deptno1
and A.max_height = B.height
and A.deptno1 = C.deptno;




2.
student 테이블에서 학생의 키가 동일 학년의 평균 키 보다 큰 학생들의 
학년과 이름과 키, 해당 학년의 평균 키를 출력 하세요.
(학년 컬럼으로 오름차순 정렬해서 출력하세요);
select * from student;

select grade, avg(height) 
from student
group by grade;

select * --grade, avg(height) 
from student s1
where s1.height > (select avg(height)
from student s2
where s2.grade = s1.grade)
;

select 
    s1.grade, 
    --avg(height) 
    s1.name,
    s1.height,
    (select avg(height)
from student s2
where s2.grade = s1.grade) avg_height    
from student s1
where s1.height > (select avg(height)
from student s2
where s2.grade = s1.grade)
order by s1.grade;

--select grade, avg(height) 
--from student
--group by grade;

select *
from student s1,
(select grade, avg(height) avg_height
from student
group by grade) s2
where s1.grade = s2.grade;


select *
from student s1,
(select grade, avg(height) avg_height
from student
group by grade) s2
where s1.grade = s2.grade
and s1.height > s2.avg_height;


select s1.grade, s1.name, s1.height, s2.avg_height
from student s1,
(select grade, avg(height) avg_height
from student
group by grade) s2
where s1.grade = s2.grade
and s1.height > s2.avg_height
order by s1.grade;