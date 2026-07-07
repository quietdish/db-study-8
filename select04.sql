/* -------------------------------------*/
단일행 함수

select * from dual;
dual : 더미 데이터가 있는 임시 테이블

select initcap('abc') from dual;
select ename, initcap(ename) from emp;

select name, LOWER(name), UPPER(name)
from student;

select name, LENGTH(name)
from student;

select
    LENGTH('abcd'), LENGTHB('abcd'),
    LENGTH('한글'), LENGTHB('한글')    --한글 한글자에 3byte
from dual;


-- 이름이 다섯자 이상 이름 가진 사람만 조회
select *
from emp
where LENGTH(ename) >= 5;   --이름길이

select '아침' || '점심',
     CONCAT('아침', '점심')
From dual;

select
    '아침' || '점심' || '저녁',
     CONCAT( CONCAT('아침', '점심') , '저녁')
From dual;




--SUBSTR(대상값|컬럼명, 시작지점(1~), 자릿수)
select
    SUBSTR('abcdefg', 1, 3),
    SUBSTR('abcdefg', 3, 5),
    SUBSTR('abcdefg', -4, 2),
    SUBSTR('abcdefg', -3, 3)
from dual;


-- INSTR(대상값|컬럼명, 찾는값)
-- INSTR(대상값|컬럼명, 찾는값, 시작위치)
-- INSTR(대상값|컬럼명, 찾는값, 시작위치, 몇번째값)

select
    '2026-01-02 10:11:33',
    INSTR('2026-01-02 10:11:33', '-'),
    INSTR('2026-01-02 10:11:33', '-', 6),
    INSTR('2026-01-02 10:11:33', ':', 15),
    INSTR('2026-01-02 10:11:33', '-', 1, 2) --첫번째부터 찾는데 -가 2번째인곳..
from dual;


select
    tel
from student;

select
    tel,
    INSTR( tel, ')' ),
    INSTR( tel, '-' )
from student;


--LPAD RPAD 왼쪽 오른쪽 채우기
select
    LPAD('문자', 10, '-'),
    RPAD('13ab', 8, '*'), 
    LPAD(5, 2, 0),
    LPAD(5, 3, 0),
    LPAD(77, 2, 0)
from dual;


select
    ' abcd '
from dual;

select
    ' * ' || ' abcd ' || ' * '
from dual;

select
    ' * ' || ' abcd ' || ' * ',
    ' * ' || LTRIM(' abcd ') || ' * ',
    ' * ' || RTRIM(' abcd ') || ' * ',
    ' * ' || TRIM(' abcd ') || ' * '
from dual;

select
    ' * ' || ' abcd ' || ' * ',
    ' * ' || LTRIM(' abcd ') || ' * ',
    ' * ' || RTRIM(' abcd ') || ' * ',
    LTRIM('**abcd**', ' * '),
    RTRIM('**abcd**', ' * ')
from dual;

--REPLACE(기준값, 찾는대상, 바꿀값)
select
    REPLACE('abcde', 'c', '/')
from dual;

select
    birthday,
    replace(birthday, '/', '$')
from student;


/* -----------------------------------------------------*/
숫자

select
    round(1.123),    --반올림
    round(1.789),
    round(1.789, 1),     --소수점 1번째 자리수까지
    round(1.789613, 3),
    round(1.789613, 0),
    round(3561.4564, -1)
from dual;

select
    TRUNC(1.123),   --버림
    TRUNC(1.789),
    TRUNC(1.789, 1),
    TRUNC(1.789613, 3),
    TRUNC(1.789613, 0),
    TRUNC(3561.4564, -1)
from dual;

select
    TRUNC(1.12244),     --버림
    TRUNC(1.167844, 2),
    MOD(15, 4),             --나머지연산 15%4
    CEIL(123.123),        --인접한 큰 정수
    FLOOR(123.123),     --인접한 작은 정수
    POWER(6, 3)             -- 6의 3제곱   6*6*6
from dual;


select
    rownum,         --조회결과에 대해서 행번호
    ceil(rownum/3)   그룹번호,
    ceil(rownum/4)   팀번호,
    empno,
    ename
from emp;

--      1/3 = 0.33  2/3 = 0.66  3/3 = 1
--              1             1           1



/* --------------------------------------- */
--날짜

select
    sysdate,     --현재 날짜
    systimestamp,   --현재 날짜시간
    months_between('2024-01-05', '2024-03-05'),
    months_between('2024-11-05', '2024-04-20')
    -- 앞날짜 - 뒷날짜 -> 월단위 환산
from dual;

select
    add_months(sysdate, 3),
    add_months(sysdate, 6),
    add_months(sysdate, -4),
    last_day(sysdate),  --해당 날짜(월) 기준 마지막 일자    28 29 30 31
    next_day(sysdate, '토'),
    next_day(sysdate, '화')
from dual;

select
    sysdate,
    round(sysdate),      --다음날로
    trunc(sysdate),
    trunc(sysdate, 'YY'),    --Year Month Day|Date
    trunc(sysdate, 'MM'),
    trunc(sysdate, 'DD'),
    add_months(sysdate, 1),  --월단위 계산 +1월
    sysdate + 3,        -- 일단위 계산 +3일
    sysdate + 7
from dual;

select
    sysdate,
    --다음달 첫날
    last_day(sysdate)+1,
    trunc( add_months (sysdate, 1), 'MM'),
    --전월의 마지막
    last_day(add_months(sysdate,-1)),
    trunc(sysdate, 'MM')-1
from dual;
