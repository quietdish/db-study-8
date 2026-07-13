select * from student;
select * from score;
select * from hakjum;
--1.
student, score, hakjum 테이블을 활용하여 다음 정보를 출력하세요.
**각 학생 별로** 점수가 몇점이고 그 점수가 어떤 학점인지를 확인하고 싶습니다.
---s.studno     s.name  s.total     h.grade
--    학번         이름     점수        학점     순으로 조회하세요.
select                      --139개..
    st.studno 학번,
    st.name 이름, 
    sc.total 점수, h.*
    --h.grade 학점
from student st, score sc, hakjum h
--where st.grade = 
where st.studno = sc.studno
--and sc.total <> h.min_point;
and sc.total between h.min_point and h.max_point;


--1.!!
select                      ---20개..!!
    st.studno 학번,
    st.name 이름, 
    sc.total 점수, --h.*
    h.grade 학점
from student st, score sc, hakjum h
--where st.grade = 
where st.studno = sc.studno
--and sc.total <> h.min_point;
and sc.total between h.min_point and h.max_point;   ---20개..!!



select                      --140개..
    s.studno 학번,
    s.name 이름, 
    ss.total 점수, 
    h.grade 학점
from student s, score ss, hakjum h
where s.studno = ss.studno;


select                      --2800개..ㅋㅋㅋ
    s.studno 학번,
    s.name 이름, 
    ss.total 점수, 
    h.grade 학점
from student s, score ss, hakjum h;




--2.
student, score, hakjum 테이블을 활용하여 다음 정보를 출력하세요.
각 학생 별로 점수가 몇점이고 그 점수가 어떤 학점인지를 확인하고 싶습니다.
---s.studno     s.name  s.total     h.grade
--    학번         이름     점수        학점     순으로 조회하세요.
select * from student;
select * from score;
select * from hakjum;
--위 내역에서 101, 102 학과에 속한 학생들의 정보만 보여주세요.
select                              --28개..ㅋ
    s.studno 학번,
    s.name 이름,
    ss.total 점수,
    h.grade 학점
from student s, score ss, hakjum h
where s.studno = ss.studno

and ss.total between h.min_point and h.max_point
and s.deptno1 in (101, 102)
order by ss.total desc;



select                              --28개..ㅋ
    s.studno 학번,
    s.name 이름,
    ss.total 점수,
    h.grade 학점
from student s, score ss, hakjum h
where s.studno = ss.studno
and deptno1 = 101;


select                              --50개..ㅋ
    s.studno 학번,
    s.name 이름,
    ss.total 점수,
    h.grade 학점
from student s, score ss, hakjum h
where s.studno = ss.studno;





select * from student;
select * from department;
select * from professor;
--3.
--학생 테이블(student)과 학과 테이블(department) , 교수 테이블(professor)을
--Join하여 301학과 속한 교수를 제외한 교수를 지도교수로 두고 있는
--학생의 이름과 학생의 학년, 학생의 지도교수 이름, 지도교수의 학과 번호, 
--지도교수가 속한 학과이름을 출력하세요.


select 
    s.name 학생이름, 
    s.grade 학생학년, 
    p.name 교수이름, 
    p.deptno 교수학과번호, 
    d.dname 교수소속학과이름
from student s, professor p, department d   --department dp
where s.profno = p.profno
--and s.deptno1 = ds.deptno
and p.deptno = d.deptno;


---3.1)
select 
    s.name 학생이름, 
    s.grade 학생학년, 
    p.name 교수이름, 
    p.deptno 교수학과번호, 
    d.dname 교수소속학과이름
from student s, professor p, department d   --department dp
where s.profno = p.profno
--and s.deptno1 = ds.deptno
and p.deptno = d.deptno             ---여기까지는 15개...
and p.deptno <> 301;                ---13개..!


---3.2)
select *
from 
    student s   --professor p, department d
    inner join professor p
    on s.profno = p.profno
    inner join department d
    on p.deptno = d.deptno
where
    p.deptno != 301;                ---13개..!
    


--- 결과 2개 더나와짜나...!ㅠㅜㅜ
    --- NAME    GRADE   NAME_1   DEPTNO     DNAME
select s.name, s.grade, p.name, p.deptno, dp.dname
from student s, professor p, department ds, department dp
where s.profno = p.profno
and s.deptno1 = ds.deptno
and p.deptno = dp.deptno;