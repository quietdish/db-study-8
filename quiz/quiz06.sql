--SUBSTR(대상값|컬럼명, 시작지점(1~), 자릿수)
select
    ENAME,
    SUBSTR(ENAME, 3, 2)
from EMP
WHERE DEPTNO = 20;

select
    ENAME,
    SUBSTR(ENAME, 1, 2) || '--'
from EMP
WHERE DEPTNO = 20;



--1. emp 테이블에서 20 번 부서에 소속된 직원들의 이름과 3-4 번째 글자만 '-' 으로 변경해서 출력하세요 .
SELECT * FROM EMP;

select
    ENAME,
    SUBSTR(ENAME, 3, 2),
    replace(ename, SUBSTR(ENAME, 3, 2), '--') replace,
    SUBSTR(ENAME, 1, 2) || '--' || substr(ename, 5) replace
from EMP
WHERE DEPTNO = 20;


--2.
Student 테이블에서 1전공(deptno1)이 101 번인 학생들의 이름과
주민등록번호를 출력하되 주민등록번호의 뒤 7자리는 ‘-’ 과 '/' 로 표시되게
출력하세요.

SELECT
    NAME, 
    --주민뒷자리숨김
    replace(JUMIN, SUBSTR(jumin, -7, 7), '-/-/-/-') 
FROM STUDENT
where deptno1 = 101;


--3, Student 테이블에서 아래 그림과 같이 1 전공이 102 번인 학생들의 이름과 전화번호,
--전화번호에서 국번 부분만 ‘*’ 처리하여 출력하세요. 단 모든 국번은 3자리로 간주합니다.
select
    name,
    tel, 
    substr(tel, 1, 4) || '***' || substr(tel, 8, 5) as "replace",
    substr(tel, 1, 4) || '***' || substr(tel, 8) as "replace",
    replace(tel, substr(tel, 5, 3), '***'),
    instr(tel, ')') "괄호위치",
    instr(tel, '-') "-표시위치",
    substr(tel, instr(tel, ')')+1, 3) 국번3자리,
    replace(tel, substr(tel, instr(tel, ')')+1, 3), '***')
from student
where deptno1 = 102;

--++Option 응용) 가운데 자리 숫자의 자리수에 맞춰서 *로 바꾸기
--   3자리 -> ***
--   4자리 -> ****
select
    tel,
    instr(tel, ')') 괄호위치,
    instr(tel, '-') "-표시위치",
    substr(tel, instr(tel, ')')+1)
from student;

--4. Student 테이블에서 아래와 같이 deptno1 이 101 번인 학과 학생들의 이름과 전화번호와 전화번호에서
--지역번호와 국번을 제외한 나머지 번호(끝 4자리 번호)를 * 로 표시해서 출력하세요.

select
    name,
    tel,
    substr(tel, -4, 4) 뒷자리네자리,
    replace(tel, substr(tel, -4, 4), '****') replace,
    substr(tel, 1, instr(tel, '-')) || '****' replace
from student
where deptno1 = 101;


