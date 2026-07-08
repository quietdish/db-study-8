/* ----------------------------- */
단일행 함수


NVL 함수
값이 null 일때 기본값 처리
NVL(대상, null일때 기본값)


select
    sal,
    comm,
    (sal*12) + comm 연봉,     --null이 포함되니까 null이 됨..
    NVL(comm, 123),
    NVL(comm, 0),
    (sal*12) + NVL(comm, 0)
from emp;


select
    sal,
    comm,
    sal*12 + comm 연봉
from emp
where comm is not null
union all                       --
select
    sal,
    comm,
    sal*12
from emp
where comm is not null;


NVL2(대상값, 있을, 없을)

select
    NVL(null, 10),
    NVL(20, 10),
    NVL2(null, '있다', '없다'),
    NVL2(1234, '있다', '없다'),
    NVL2(1234, '1234', '없다')    
from dual;

select
    sal,
    comm,
    (sal*12) + NVL(comm, 0),
    NVL2(comm, comm, 0),
    (sal*12) + NVL2(comm, comm, 0),
    NVL2(comm, (sal*12)+comm, (sal*12))
from emp;


***DECODE

DECODE(대상, 비교값, '같다', '다르다')
DECODE(대상, 비교값, '같다', (DECODE(대상, 비교값, '같다', '다르다')))
DECODE(대상, 비교값1, '같다1', 비교값2, '같다2', 비교값3, '같다3', '다르다')
DECODE(대상, 비교값1, '같다1', 비교값2, '같다2', 비교값3, '같다3')   -> 마지막 다르다 생략 -> NULL

select
    decode(10, 10, '같다', '다르다'),
    decode(10, 20, '같다', '다르다'),
    decode(10, 10, '같다'),
    decode(10, 20, '같다'),       -- 다르다 생략 -> null
    decode(10, 20, '같다', null)
from dual;

select
    decode(10, 10, '같다', null),
    decode(10, 10, '10이다', 20, '20이다', 30, '30이다', 40, '40이다', '아니다'),
    decode(30, 10, '10이다', 20, '20이다', 30, '30이다', 40, '40이다'),
    decode(40, 10, '10이다', 20, '20이다', 30, '30이다', 40, '40이다', null),
    decode(99, 10, '10이다', 20, '20이다', 30, '30이다', 40, '40이다', null)
from dual;


swith(20):
    case 20: '20이다'
    case 30: ...
    
    
select
    name,
    deptno,
    decode(deptno, 101, '컴공', 102, '전기', 103, '기계', 201, '물리', 202, '화학', 203, '수학', '기타전공') 학과이름,
    '전공학과:' || decode(deptno, 101, '컴공', 102, '전기', 103, '기계', 201, '물리', 202, '화학', 203, '수학', '기타전공') 학과이름
from professor;


*** CASE문

select *
from student;
--학년 1 2 3 4
--학년 구분 -> 컬럼
-- 1 2 저학년
-- 3 4 고학년

select
    grade,
    decode(grade, 1, '저학년', 2, '저학년', 3, '고학년', 4, '고학년', '범위벗어남') 구분,
    CASE grade
        when 1 then '저학년'       -- 1,2,3 이어서 못씀..
        when 2 then '저학년'
        when 3 then '고학년'
        when 4 then '고학년'
        else '범위 벗어남'
    end as 구분CASE,
    case
        when grade in (1,2) then '저학년'
        when grade between 3 and 4 then '고학년'
        else '어쩌구...'
    end 구분case2
from student;



-----------------------
연봉계산

select
    sal,
    comm,
    sal*12 + comm 연봉1,
    sal*12 + NVL(comm, 0) 연봉2,          -- 제일 간단..
    sal*12 + NVL2(comm, comm, 0) 연봉3,
    NVL2(comm, sal*12+comm, sal*12) 연봉4,
    sal*12 + decode(comm, null, 0, comm) 연봉5,
    case comm
        when null then (sal*12)     -- comm = null      comm is null
        else (sal*12 + comm)
    end 연봉6,                       -- 안되는 케이스
    case
        when comm is null then (sal*12)
        when comm is not null then (sal*12 + comm)
    end 연봉7
from emp;
