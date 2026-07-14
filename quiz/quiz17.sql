--quiz17

select * from student;      ---20
select * from department;   ---12
--1. 학생 테이블 (student) 과 학과 테이블 (department)을 사용하여
--학생이름, 1전공학과번호(deptno1) , 1전공 학과 이름을 출력하세요.
---s.name, ( s.deptno1 = d.deptno ), d.dname

--ssam ~
select *
from student;
select *
from department;

select s.name, s.deptno1, d.dname
from student s, department d
where s.deptno1 = d.deptno;   --INNER JOIN  
---ssam


select                          ---20개..!! 
    s.name STU_NAME,
    s.deptno1,
    d.dname DEPT_NAME
from student s, department d
where s.deptno1 = d.deptno      --inner join
--inner join department d
--and s.deptno1 = d.deptno
ORDER BY S.DEPTNO1;             ---정렬까지~..!





select * from emp2;         ---20
select * from p_grade;      ---6
--2. emp2 테이블과 p_grade 테이블을 조회하여
현재 직급이 있는 사원의 이름과 직급, 현재 연봉, 해당 직급의 
--       e.name, (e.position = p.position),  e.pay,
---       NAME            POSITION            PAY
연봉의 하한금액과 상한 금액을 아래 결과 화면과 같이 출력하세요.
-- p.s_pay --- LOW PAY
-- p.e_pay --- HIGH PAY

--ssam ~
select * from emp2
where position is not null;

select 
    e.name, 
    e.position, 
    TO_CHAR(e.pay, '999,999,999') pay,
    TO_CHAR(p.s_pay, '999,999,999') "LOW PAY",
    TO_CHAR(p.e_pay, '999,999,999') "HIGH PAY"
from emp2 e, p_grade p
where e.position is not null
--and e.position = p.position;  --INNER JOIN
and e.position = p.position(+);  --OUTER JOIN       
---ssam



from emp2 e LEFT OUTER JOIN p_grade p
ON e.position = p.position;  --OUTER JOIN   --ssam



select *
from emp2 e
where e.position is not null;   ---포지션 없는사람 배제...


select 
    e.name NAME,
    e.position POSITION,
    to_char(e.pay, '999,999,999') PAY       ---콤마 적용
from emp2 e
where e.position is not null;


select * from emp2;         ---20
select * from p_grade;      ---6
---

select 
    e.name NAME,
    e.position POSITION,
    to_char(e.pay, '999,999,999') PAY,
    to_char(p.s_pay, '999,999,999') s_PAY,
    to_char(p.e_pay, '999,999,999') e_PAY
    ---p.s_pay, p.e_pay
from emp2 e, p_grade p
where e.position is not null
--and e.position = p.position;            --inner join
and e.position = p.position(+);         --outer join
--order by e.pay;


--from emp2 e, p_grade p
from emp2 e left outer join p_grade p
on e.position = p.position;




select                      ---
    e.name NAME,
    e.position POSITION,
    e.pay PAY,
    p.s_pay
from emp e, p_grade p
on e.position = p.position
inner join p_grade p
on e.pay;
    



select * from emp2;         ---20
select * from p_grade;      ---6
--3. Emp2 테이블과 p_grade 테이블을 조회하여
--      e.name        (e.position = p.position)
---     NAME          ?     지금포지션
사원들의 이름과 나이, 현재 직급, 예상 직급 을 출력하세요.
---      ? 한국나이     ?       그나이에맞는포지션
예상 직급은 나이로 계산하며 해당 나이가 받아야 하는 직급을 의미합니다.
나이는 '2010-05-30'을 기준으로 하되 가능하면 trunc 로 
---소수점 이하는 절삭해서 계산하세요.
-- 심플 한국나이
select 
    birthday,
    2010 - to_char(birthday, 'yyyy') + 1 한국나이
from emp2;

select 
    --birthday,
    e.name,
    2010 - to_char(birthday, 'yyyy') + 1 한국나이,
    e.position 지금포지션,
    p.position 그나이에맞는포지션
    --p.*
from emp2 e, p_grade p
--where 나이 between p.s_age and p.e_age;
where (2010 - to_char(birthday, 'yyyy') + 1) between p.s_age and p.e_age;
--조인 조건     나이 s_age e_age 사이에 들어가느냐...


select * from emp2;         ---20
select * from p_grade;      ---6
-- 만나이 -------------------------------------------------
select 
    birthday,
    to_date('2010-05-30')
from emp2;


select 
    name,
    birthday,
    to_date('2010-05-30'),
    to_date('2010-05-30') - birthday 일단위계산,
    (to_date('2010-05-30') - birthday)/365,
    trunc((to_date('2010-05-30') - birthday)/365) 일단위계산나이,
    months_between(to_date('2010-05-30'), birthday) 월단위차이,
    months_between(to_date('2010-05-30'), birthday)/12 월단위차이계산,
    trunc(months_between(to_date('2010-05-30'), birthday)/12) 월단위차이계산나이
--where (2010 - to_char(birthday, 'yyyy') + 1) between p.s_age and p.e_age;
from emp2;
------------------------------





select * from customer;     --20
select * from gift;         --10
--4 . customer 테이블과 gift 테이블을 Join하여 고객이 자기 포인트보다 낮은 
포인트의 상품 중 한가지를 선택할 수 있다고 할 때 Notebook 을 선택할 수 있는
고객명과 포인트, 상품명을 출력하세요.
-- c.g_name 고객명... g.g_name 상품명..
---          GNAME       GNAME_1
-- Notebook G_START 600001 / G_END 700000
                --POINT

select *
from customer c, gift g
where c.point between g.g_start and g.g_end;

select c.gname, c.point, g.gname
from customer c, gift g
where c.point between g.g_start and g.g_end;

select c.gname, c.point, g.gname
from customer c, gift g
where c.point between g.g_start and g.g_end
and g.gname = 'Notebook';

select c.gname, c.point, g.gname, g.*
from customer c, gift g
where c.point between g.g_start and g.g_end
--and g.gname = 'Notebook';
and g.gno = 7;

select
    c.gname, c.point, g.gname
    --, g.*
from customer c, gift g
where c.point between g.g_start and g.g_end
--and g.gname = 'Notebook';
and g.gno = 7;


-------------
select * from customer;     --20
select * from gift;         --10
-------------


select *                    ---88개        
from customer c, gift g
where c.point >= g.g_start;

select *                    ---88개
from customer c, gift g
where c.point >= g.g_start
order by c.gno, g.gno;

select
    c.gname, c.point, g.gname   ---개
from customer c, gift g
where c.point >= g.g_start
and g.gno = 7   --노트북
order by c.gno, g.gno;

---2way
select
    c.gname, c.point, g.gname
    , g.*
from customer c, gift g
where c.point between g.g_start and g.g_end;

select
    c.gname, c.point, g.gname
    , g.*
from customer c, gift g
where c.point between g.g_start and g.g_end
and g.gno >= 7;

---2way-편법 ㅇㅂㅇ;----------------------------------------
select
    c.gname, c.point, 'Notebook' --g.gname
    --, g.*
from customer c, gift g
where c.point between g.g_start and g.g_end
and g.gno >= 7;

---서브쿼리 맛보기....
--- 조건 ? 참 : 거짓
-- 조건 ? 참 : (조건 ? (조건 ? 참 : 거짓) : 거짓)

쿼리 안에 쿼리 -> 서브쿼리

select
from
where

select (select from where)
from (select from where)
where (select from where)
(select from where)
;

select g_start
from gift
where gno = 7;

select *
from customer
where point >= 600001;

select *
from customer
where point >= (select g_start      ---(600001); -> (3줄복붙)
                from gift
                where gno = 7);





select * from professor;    --16
--5. professor 테이블에서    --- 테이블 2개라고 치고...조인..
교수의 번호, 교수이름, 입사일, 자신보다 입사일 빠른 사람 인원수를 출력하세요.
-- profno, name, hiredate, ?
단 자신보다 입사일이 빠른 사람수를 오름차순으로 출력하세요. ---COUNT

--85/09/18
select count(*)             --4명
from professor
where hiredate < '85/09/18';

select count(*)             --명
from professor
where hiredate < '85/09/18';

select *
from professor p1, professor p2
where p1.hiredate > p2.hiredate;

select 
    p1.profno, p1.name, p1.hiredate,
    p2.profno, p2.name, p2.hiredate
from professor p1, professor p2
where p1.hiredate > p2.hiredate;

select 
    p1.profno --, p1.name, p1.hiredate,        --group by로 묶을거래..~
    ,
    count(p2.profno)
    p2.profno, p2.name, p2.hiredate
from professor p1, professor p2
where p1.hiredate > p2.hiredate
group by p1.profno;

select                                      --오류남
    p1.profno, p1.name, p1.hiredate,        --group by로 묶을거래..~
    count(p2.profno) count
    --p2.profno, p2.name, p2.hiredate
from professor p1, professor p2
    --where p1.hiredate > p2.hiredate      --inner join(15명)  조인조건에 맞는게 없으면 제외
    where p1.hiredate > p2.hiredate(+)      --제일 먼저 입사한 머피가 사라지지않도록 outer
group by p1.profno, p1.name, p1.hiredate
order by 4;

--2way-------------------------------------이너조인 ->아우터조인
select          --위에서 가져옴..이너조인.
    p1.profno, p1.name, p1.hiredate,
    p2.profno, p2.name, p2.hiredate
from professor p1, professor p2
where p1.hiredate > p2.hiredate;


select 
    p1.profno, p1.name, p1.hiredate,
    count(p2.profno) count
--    count(*) count
    --p2.profno, p2.name, p2.hiredate
from professor p1, professor p2
where p1.hiredate > p2.hiredate(+)
group by p1.profno, p1.name, p1.hiredate
order by 4;
--order by count;

--순위 입사일자 빠른거 기준으로 순위 RANK

select                          --16명
    profno, name, hiredate,
    --dense_
    rank() over (order by hiredate)
from professor;

select                          --16명 
    profno, name, hiredate,
    --dense_
    rank() over (order by hiredate) -1 as "count"
from professor;





select * from emp;          --12명
--6. emp 테이블에서 사원번호,
사원이름, 입사일, 자신보다 먼저 입사한 사람 인원수를 출력하세요.
-- ename, hiredate, ?
단 자신보다 입사일이 빠른 사람수를 오름차순으로 출력하세요.   ---COUNT

select *
from emp e1, emp e2
where e1.hiredate > e2.hiredate(+)      --outer join
group by e1.empno, e1.ename, e1.hiredate
;

select e1.empno, e1.ename, e1.hiredate, count(e2.empno) count
from emp e1, emp e2
where e1.hiredate > e2.hiredate(+)      --outer join
group by e1.empno, e1.ename, e1.hiredate
order by e1.hiredate
;

select
    empno, ename, hiredate,
    rank() over (order by hiredate) -1 "count"
from emp;