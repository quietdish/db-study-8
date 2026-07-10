/*--------------------------------------------------*/
JOIN 조인

--JOIN 기준 -> 어떤 것(컬럼/값)을 기준으로 테이블 데이터를 합쳐서(연결) 조회

select * from emp;      --deptno 컬럼 부서번호
select * from dept;     -- 부서정보 테이블 deptno 컬럼(식별자)

select * 
--from emp A, dept B
from emp e, dept d
where e.deptno = d.deptno;  --join 기준


select e.empno, e.ename, d.dname, d.loc, e.deptno, d.deptno     
        --별칭 안쳤을때 오류남..어느건지 애매해서..
--select * 
--from emp A, dept B
from emp e, dept d
where e.deptno = d.deptno;  --join 기준


select e.empno, e.ename, d.dname, d.loc, e.deptno, d.deptno 
--select * 
--from emp A, dept B
from emp e inner join dept d
on e.deptno = d.deptno;  --join 기준

---------- 책p.205 내용..ㅋ 실습 8-2 | 열 이름을 비교하는 조건식으로 조인하기
select * 
    from emp, dept
    where emp.deptno = dept.deptno
order by empno;



--emp, dept 조인 + 부서번호 20, 30번 부서만 조회 
--조건이 붙는 경우..

select *
from emp e, dept d
where e.deptno = d.deptno;


select *
from emp e, dept d
where e.deptno = d.deptno
and e.deptno in (20, 30);


-- 오라클 방식 (비ANSIJOIN 쿼리) ㅎㅂㅎ
select e.empno, e.ename, e.deptno, d.dname, d.loc
--select *
from emp e, dept d
where e.deptno = d.deptno
and e.deptno in (20, 30);

-- ANSIJOIN 쿼리                ㅎㅂㅎ
select e.empno, e.ename, d.dname, d.loc, e.deptno, d.deptno 
--select * 
--from emp A, dept B
from emp e inner join dept d
on e.deptno = d.deptno  --join 기준
where e.deptno in (20, 30);


select * from emp;      --deptno 컬럼 부서번호
select * from dept;     -- 부서정보 테이블 deptno 컬럼(식별자)

/*---------------------------- 50line 오라클 방식 ㅎㅂㅎ */
select *
from emp e, dept d;







select *
from emp e, dept d;     -- 조인 조건 누락 -> 카티션 곱
---------------------------------------------------------------------------------

select * from student;      --맨끝열 profno = 지도교수...
select * from professor;    -- profno 교수번호 컬럼

select *     
from student s, professor p
where s.profno = p.profno;

select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
--select *     
from student s, professor p
where s.profno = p.profno;

--위에거랑 결과 똑같음...
select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
--select *     
from student s inner join professor p       -- , -> inner join..
on s.profno = p.profno;                  -- where -> on..



/*--------------------------------*/

inner join vs outer join


select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
--select *     
from student s inner join professor p       -- , -> inner join..
on s.profno = p.profno;
-- 학생X교수 -> data 15개_

select count(*) from student;       --20명
select count(*) from professor;     --16명


select * from student;      --맨끝열 profno = 지도교수...      (null) 있음...
select * from professor;    -- profno 교수번호 컬럼            (null) 없음..!
-- inner join 수행 -> 조인기준에 따라서 합침 (profno가 같은가?--기준..)
                                        --> profno null이면 비교불가 -> 제외시켜버림. 그래서 15개.._
                                        
-- outer join..........
select *
from student s, professor p
--where s.profno = p.profno;    --이너조인..
where s.profno = p.profno(+);   -- 20개.. 아우터조인..!
--where p.profno(+) = s.profno;  --(+)위치에 따라 달라짐...
--where s.profno(+) = p.profno;   -- 22개...
--where p.profno = s.profno(+);



select s.studno, s.name, s.profno, p.profno, p.name       --20
--select *
from student s left outer join professor p               --20
--from student p left outer join professor s   --순서 중요 .. 22개..!
--from student s right outer join professor p              --22
--from student p right outer join professor s              --20?
on s.profno = p.profno;    --복붙해서 수정했으 where -> on ...20개..!
--where s.profno = p.profno(+);


select s.studno, s.name,
    NVL2(s.profno, '지도교수배정완료', '지도교수배정요망'), --decode    case when
    s.profno, p.profno, p.name                            --20
--select *
from student s left outer join professor p               --20
--from student p left outer join professor s   --순서 중요 .. 22개..!
--from student s right outer join professor p              --22
--from student p right outer join professor s              --20?
on s.profno = p.profno;    --복붙해서 수정했으 where -> on ...20개..!
--where s.profno = p.profno(+);


/*----------------------------------------------*/
join 결과 갯수 정리..?ㅎ

--inner 15
select count(*)
from student s, professor p
where s.profno = p.profno;
>> 15개      학생20    교수16    학생에 교수배정 null 5개 -> 제외
                    이너조인으로 연결 가능한 대상 15개 -> 결과 15개

--outer
select *
from student s, professor p
where s.profno = p.profno(+);   -- 20개.. 아우터조인..!
>> 20개


select *
--select count(*)
from professor s, student p     --반대로..
where s.profno = p.profno(+);   --22    -- 교수기준...
>> 22개

select *
--select *
from student p, professor s
where p.profno = s.profno(+);   --20
>> 22개      교수갯수 16개    -> 학생20개    학생 null (조회대상 X)...


select *
--select count(*)
from professor p, student s
where p.profno = s.profno(+);   --22


-- 지도학생이 없는 교수의 수는? 7
--select *
select count(*)
from professor p, student s
where p.profno = s.profno(+)   --22
and s.studno is null;               --7