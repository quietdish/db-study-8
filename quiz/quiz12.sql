select
    name, jumin,
    birthday,
    jumin as 분기
from student;

-- select04 참고
select
    rownum,         --조회결과에 대해서 행번호
    ceil(rownum/3)   그룹번호,  --인접한 큰 정수
    ceil(rownum/4)   팀번호,
    empno,
    ename
from emp;

--1. student 테이블을 참고해서 진행하세요.
학생들의 이름과 주민번호, 생일 그리고  jumin, birthday 참고해서 태어난 날짜별로 
분기를 표시하는 쿼리를 작성하세요. 태어난 월에 따라서 각 분기로 표시
--1~3 1분기 --4~6 2분기 --7~9 3분기 --10~12 4분기
select
    name, jumin, birthday,
    ceil(SUBSTR(jumin, 3, 2) / 3) as 분기
from student;

select
    name, jumin, birthday,
--    to_char(birthday, 'mm'),
--    decode(to_char(birthday, 'mm'), '01', '1분기', ...
--    case to_char(birthday, 'mm')
--        when '01' then '1분기'
--        when '02' then '2분기'
--    end,
    case
        when to_char(birthday, 'mm') in ('01', '02', '03') then '1분기'
        when to_char(birthday, 'mm') in ('04', '05', '06') then '2분기'
        when to_char(birthday, 'mm') in ('07', '08', '09') then '3분기'
        else '4분기'
    end 분기,
--    ceil(to_char(birthday, 'mm')/3) || '분기' 분기
    ceil(to_number(to_char(birthday, 'mm'))/3) || '분기' 분기
from student;


select * from emp;
--2. emp 테이블을 조회하여 empno , ename , sal , LEVEL(급여등급)을 출력하세요.
단 급여등급은 sal 을 기준으로
1 - 1000 이면 Level 1, 1001 - 2000 이면 Level 2,
2001 - 3000 이면 Level 3, 3001 - 4000 이면 Level 4 ,
--4001 보다 많으면 Level 5 로 출력하세요.

select 
    empno, ename, sal
from emp;

select 
    empno, ename, sal,
    case
        when sal between 1 and 1000 then 'level 1'
        when sal between 1001 and 2000 then 'level 2'
        when sal between 2001 and 3000 then 'level 3'
        when sal between 3001 and 4000 then 'level 4'
        else 'level 5'
    end 급여등급
from emp;