/* ------------------------------------*/
조건 WHERE 절
필터링 기능, 원하는 조건에 따라서 조회

SELECT ...
FROM ...
WHERE ... ;

SELECT *
FROM emp;      --전체 데이터 조회


SELECT *
FROM emp
WHERE sal > 2500;
-- emp 테이블에서 sal 컬럼값이 2500을 초과하는 모든 데이터 조회

select ename
from emp
where sal > 2500;
-- emp 테이블에서 sal 컬럼값이 2500을 초과하는 직원들의 이름을 조회

select *
from emp
where job = 'SALESMAN';
-- emp 테이블에서 job(직업)이 세일즈맨인 직원들만 전체 걸럼 조회

select * from emp;  --전체테이블 ㅇㅅㅇ..
select *
from emp
where deptno = 10;
-- 부서번호가 10번인 사원들 정보 조회 (10번 부서에 속한)

select *
from emp
--where deptno != 10;
where deptno <> 10;
-- 부서번호가 10번이 아닌 사원정보

select *
from STUDENT
--where WEIGHT >= 55; --55kg 이상
--WHERE WEIGHT >= 55 AND WEIGHT <= 70;    --55kg <= 대상 <= 70  -- AND OR
where weight between 55 and 70;

select * from student;
select * from student  -- 1~3 학년만 조회
--where grade >= 1 and grade <= 3;
--where grade between 1 and 3;
--where grade = 1 or grade = 2 or grade = 3;
--where grade <> 4;
--where grade != 4;
where grade in (1,2,3);     --책 111쪽에 있눼

-- not
-- 2,4 학년만 조회
select * from student
--where grade in (2,4);
--where grade = 2 or grade = 4;
--where grade != 1 and grade <> 3;
where grade not in (1,3);           --책 113



like 패턴 검색 (문자)
    % : 0~n개 아무갯수나 가능
    _ : 해당 위치에 한개

select * from emp
--where ename = 'SMITH';  --대문자해야 나옴....  책 115
--where ename like '%M%'; -- 12334M24234 M123123123 234234M
--where ename like 'M%';
--where ename like '%N';
--where ename like '_M%'; -- OM   OM1234  SMITH
where ename like '__M%';    -- JAMES
--name title.. like '%만두%'


-- null값 비교
select * from emp                           --책 119
--where comm is null;       --where comm = null; 는 출력값 안나옴.
where comm is not null;                     --책 121



날짜비교
1201
1221
미래일수록 큰 값
과거일수록 작은 값

select * from emp       --테이블 팝업설명 shift + F4 [data_type]
--where hiredate = '80/12/17';    --YY/MM/DD
--where hiredate = '1980-12-17'     --YYYY-MM-DD
--where hiredate > '80/08/20';
where hiredate <= '1981-04-05';

desc emp;



/* ------------------------------------*/
정렬 order by
단순조회 -> 정렬을 명시하지 않으면 순서보장X
order by 정렬기준컬럼명 [ASC | DESC] [오름차순 | 내림차순]

SELECT ...
FROM ...
WHERE ...
ORDER BY ...

SELECT ...
FROM ...
ORDER BY ...
;

SELECT * FROM STUDENT;
SELECT * FROM STUDENT
--ORDER BY NAME;  -- ASC 기본값 오름차순
order by name ASC;

--내림차순
select * from student
order by name DESC;

--학생들 학년기준으로 내림차순 정렬 -> 이름과 학년을 조회
select * from student
order by grade desc;

select name, grade
from student
order by grade desc;

-- 학생테이블 기준 1,2,3 학년 학생들을 키 내림차순 순서로 조회
select * from student
where grade in (1,2,3)
order by height desc;


select * 
from student
where grade in (1,2,3)
order by grade desc, height asc;
--order by grade, height desc;

select *
from student
where grade in (1,2,3)
order by height, grade desc;


select * 
from student
--order by birthday;  --오름차순 작은값->큰값  작을수록 더 과거   클수록 더 미래
order by birthday desc;     --내림차순. 미래,,