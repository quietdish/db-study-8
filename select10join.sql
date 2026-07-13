
--학과정보
select * from department;
select * from student;
select * from professor;

--조인...
select * 
from student s, department d
where s.deptno1 = d.deptno;

select s.name, s.deptno1, d.dname
from student s, department d
where s.deptno1 = d.deptno;

--걍 해본거~....
select d.dname, d.deptno, s.name
from student s, department d
where s.deptno1 = d.deptno;


select *
from student s, professor p
where s.profno = p.profno;


---
select * from department;


select *
from student s, professor p, department d   --180개;;..
where s.profno = p.profno;

select *
from student s, professor p, department d   ---180개;;..X
where s.profno = p.profno
and s.deptno1 = d.deptno;                   --15개..!


select s.name, p.name, d.dname  ---추가...
from 
student s inner join professor p
on s.profno = p.profno
--where s.profno = p.profno
inner join department d
--and s.deptno1 = d.deptno;
on s.deptno1 = d.deptno;


select *
from student s, professor p, department d   ---180개;;..X
where s.profno = p.profno
and s.deptno1 = d.deptno
and s.deptno1 = 101;



SELECT * FROM student; 
select * from department;
select * from professor;
----------------------------------------------------
---name,    deptno1,   dname,       name,   deptno
1) 학생명, 학생학과번호, 학생의 학과명, 교수명, 교수학과번호
select s.name, s.deptno1, d.deptno, p.name, p.deptno
from student s, professor p, department d   ---180개;;..X
where s.profno = p.profno
and s.deptno1 = d.deptno;

--  -                                       deptno
2) 학생명, 학생학과번호, 교수의 학과명, 교수명, 교수학과번호
select s.name, s.deptno1, d.dname, p.name, p.deptno
from student s, professor p, department d   ---180개;;..X
where s.profno = p.profno
and s.deptno1 = d.deptno;


--s.name, s.deptno1, s.deptno1, p.name, p.deptno, d.dname
3) 학생명, 학생학과번호, 학생의 학과명, 교수명, 교수학과번호, 교수의 학과명
select ---오류남~ 밑에꺼~임..
from student s, professor p, department ds, department dp  ---180개;;..X
where s.profno = p.profno   -- 학생 <--> 지도교수     (profno기준)
and s.deptno1 = ds.deptno   -- 학생 <--> 학과정보     (deptno1 | deptno)
and p.deptno = dp.deptno;   -- 교수 <--> 학과정보     (deptno 기준)
                            ---15개...
---3)
select s.name, s.deptno1, ds.dname, p.name, p.deptno, dp.dname
from student s, professor p, department ds, department dp  ---180개;;..X
where s.profno = p.profno   -- 학생 <--> 지도교수     (profno기준)
and s.deptno1 = ds.deptno   -- 학생 <--> 학과정보     (deptno1 | deptno)
and p.deptno = dp.deptno;   -- 교수 <--> 학과정보     (deptno 기준)
                            ---15개..~
                            
                            
---3교시-----------------------------------------------------------------
inner join
outer join

---
등가조인            조인의 연결 조건 = 같다
비등가조인           조인의 연결 조건 = 같다가 아닌 다른 조건으로 연결


select * from customer;
select * from gift;

point 점수    g_start g_end 사이에 들어가면 해당 사은품 수령


select * 
from customer c, gift g
where c.point between g.g_start and g.g_end;    ---범위를 비교하겠다? 어떻게 연결할거냐~?



---
self join                     ---하나의 테이블을 두 개처럼 사용하여 자기 자신과 조인하는 것..


select * from emp;
---상사 MGR
select *
from emp e1, emp e2
where e1.mgr = e2.empno;    ---empno상사번호...


select * from emp2;     ---맨오른쪽 pempno 부모? 직속팀장느낌?

select *
from emp2 A, emp2 B
where A.pempno = B.empno;

                    --- A.pempno = B.empno
select A.empno, A.name, A.pempno, B.empno, B.name
from emp2 A, emp2 B
where A.pempno = B.empno;
