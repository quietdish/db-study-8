/* -----------------------------*/
집합연산자
합집합 union       (합치면서 중복제거)
      union all   (전부다 합치기 중복제거X)
교집합 intersect
차집합 minus

/* 제약조건
 1. 컬럼 갯수 동일
 2. 컬럼 데이터타입 동일
 3. 컬럼명은 달라도 상관없음 */


--학생 101학과 학생 + 102학과 학생 정보 총합 조회
select * from student;
select * from student
where deptno1 in (101, 102);

select * 
from student
where deptno1 = 101
union all
select * 
from student
where deptno1 = 102;

--학생들 데이터
-- 101번 학과 학생 + 102학과 학생 중 키 170넘는 학생

select * 
from student
where deptno1 = 101
union all
select * 
from student
where deptno1 = 102 and height > 170;

select * 
from student
where deptno1 = 101 or(deptno1 = 102 and height > 170);

-101번 학과에 속한 학생들 + 101번 학과에 재직중인 교수들 한번에 조회
select * 
from student   -- 12개
where deptno1 = 101
union all
select * 
from professor  -- 10개
where deptno = 101;

select studno, name, deptno1
from student            -- 12개
where deptno1 = 101
union all
select profno, name, deptno
from professor          -- 10개
where deptno = 101;


select studno 식별번호, name 이름, deptno1 학과
from student            -- 12개
where deptno1 = 101
--order by name
union all
select profno, name, deptno
from professor          -- 10개
where deptno = 101
--order by name;
--order by 이름;
order by 2;




select studno 식별번호, name 이름, deptno1 학과, tel 연락처
from student            -- 12개
where deptno1 = 101
--order by name
union all
select profno, name, deptno, email  --email -> null도 가능
from professor          -- 10개
where deptno = 101
--order by name;
--order by 이름;
order by 2;



-- 교집합
select * 
from student
where deptno1 = 101
intersect
select * 
from student
where deptno2 = 201;

--where deptno1 = 101 and deptno2 = 201


-- 차집합
select *
from emp
where job = 'SALESMAN' and comm > 0;

-- 차집합 이전 수상자 빼
select *
from emp
where hiredate < '1982-01-01';
 
select *
from emp
 where (job = 'SALESMAN' AND comm > 0) and (hiredate >= '1982-01-01')