select * from student;
-- 1. Student 테이블의 birthday 컬럼을 사용하여 생일이
-- 1월인 학생의 이름과 birthday 를 출력하세요.
select
    studno,
    name,
    --birthday,
    to_char(birthday, 'yyyy-mm-dd') birthday
from student
where to_char(birthday, 'mm') = '01';


-- 2. emp 테이블의 hiredate 컬럼을 사용하여 입사일이 1,2,3 월인 사람들의
-- 사번과 이름, 입사일을 출력하세요.
select *
from emp;

SELECT
    EMPNO,
    ENAME,
    HIREDATE
FROM EMP
where
    --to_number(to_char(hiredate, 'mm')) <= 3;
    --to_char(hiredate, 'mm') = '01'
    to_char(hiredate, 'mm') in ('01', '02', '03');
--  to_char(hiredate, 'mm') = '01' or
--  to_char(hiredate, 'mm') = '02' or
--  to_char(hiredate, 'mm') = '03';