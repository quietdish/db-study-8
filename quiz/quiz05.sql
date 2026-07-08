select profno, name, ID, HEIGHT
from student;

SELECT PROFNO, NAME, ID
FROM professor;

select 
STUDNO 번호, name 이름, ID 아이디
from student
WHERE HEIGHT BETWEEN 160 AND 175
--where height >= 160 and height <= 175
UNION
SELECT
PROFNO 번호, NAME 이름, ID 아이디
FROM professor
WHERE DEPTNO IN (101,102,103,201)
AND BONUS IS NULL;



select * from student;
select * from professor;
--1. 학생들 중에 키가 160~175인 학생들의 학번/이름/아이디 와
-- 교수들 중에 101/102/103/201 학과에 속하면서 보너스를 받지 않는 교수들의
-- 교수번호/이름/아이디 를 모두 취합해서 한번에 보여주시오.

select STUDNO 번호, name 이름, ID 아이디
from student
WHERE HEIGHT BETWEEN 160 AND 175
--where height >= 160 and height <= 175;     --13명

union all

SELECT
PROFNO 번호, NAME 이름, ID 아이디
FROM professor
WHERE DEPTNO IN (101,102,103,201)           --4명
    AND BONUS IS NULL;                      --총 17명


select * from student;
--2.학생들의 이름, 아이디, 주민번호를 아래와 같은 형태로 정리해서 보여주시오.
--SUBSTR(대상값|컬럼명, 시작지점(1~), 자릿수)
SELECT 
    '이름:' || NAME 이름, 
    '아이디:' || ID 아이디,
    '주민번호:' || substr(JUMIN, 1, 6) || '-' || substr(JUMIN, 7) 주민번호,
    '주민번호:' || substr(JUMIN, 1, 6) || '-' || substr(JUMIN, 7, 7) 주민번호,
    '주민번호:' || substr(JUMIN, 1, 6) || '-' || substr(JUMIN, -7, 7) 주민번호
FROM STUDENT;