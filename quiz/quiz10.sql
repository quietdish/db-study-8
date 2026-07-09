select *
from professor;
--1. professor 테이블에서 교수의 이름과 부서번호를 출력하고
--101 번 부서 중에서 이름이 "Audie Murphy" 교수에게 "BEST!" 라고 출력하고
--101번 부서 중에서 이름이 "Audie Murphy" 교수가 아닌 나머지에는 NULL 값을 출력하세요.
--만약 101 번 외 다른 학과에 "Audie Murphy" 교수가 있어도 "BEST!" 가 출력되면 안됩니다.

select
    deptno,
    name,
    decode(deptno, 101,
        decode(name, 'Audie Murphy', 'BEST!', NULL),
        NULL
    ) AS RESULT    
from professor;


select *
from professor;
--2. professor 테이블에서 교수의 이름과 부서번호를 출력하고 101번 부서 중에서
-- 이름이 "Audie Murphy" 교수에게 비고란에 “BEST!”라고 출력하고 101번 학과의
--"Audie Murphy" 교수 외에는 비고란에 “GOOD!”을 출력하고 101번 교수가 아닐
--경우는 비고란이 공란이 되도록 출력하세요.
select
    deptno,
    name,
    decode(deptno, 101,
        decode(name, 'Audie Murphy', 'BEST!', 'GOOD!'),
        NULL
    ) AS 비고
from professor;

select *
from professor;
--3. professor 테이블에서 교수의 이름과 부서번호를 출력하고 101 번 부서 중에서
--이름이 "Audie Murphy" 교수에게 비고란에 “BEST!” 이라고 출력하고
--101번 학과의 "Audie Murphy" 교수 외에는 비고란에 “GOOD!”을 출력하고
--101번 교수가 아닐 경우는 비고란에 "N/A" 을 출력하세요.
select
    deptno,
    name,
    decode(deptno, 101,
        decode(name, 'Audie Murphy', 'BEST!', 'GOOD!'),
        'N/A'
    ) AS 비고
from professor;


select *
from student;
--4. Student 테이블을 사용하여 제1전공 (deptno1)이 101 번인 학과 학생들의
--이름과 주민번호, 성별을 출력하되 성별은 주민번호(jumin) 컬럼을 이용하여
--7번째 숫자가 1일 경우 '남자' , 2일 경우 '여자' 로 출력하세요.
SELECT
    name, 
    jumin,
    substr('jumin', 7, 1),
    decode(substr(jumin, 7, 1), '1', '남자', '2', '여자') 성별
from student
where deptno1 = 101;


select *
from student;
--5. Student 테이블에서 1 전공이 (deptno1) 101번인 학생의 이름과 연락처와
--지역을 출력하세요. 단,지역번호가 02 는 "SEOUL" , 031 은 "GYEONGGI" ,
--051 은 "BUSAN" , 052 는 "ULSAN" , 055 는 "GYEONGNAM"입니다.
select
    name,
    tel,
    substr(tel, 1, 3),  --'02)'
    decode( substr(tel, 1, 3), '02)', '서울'),
    substr(tel, 1, (instr(tel, ')') - 1) 지역번호,
    decode( substr(tel, 1, instr(tel, ')') - 1)
        '02', '서울',
        '031', '경기',
        '그외 기타 지역'
    ) 지역명
    
    --case substr(tel, 1, instr(tel, ')') -1)
    
    
from student     
where deptno1 = 101;