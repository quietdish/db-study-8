--1.
--Student 테이블에서 모든 학생들의 이름과 태어난 생일 년도, 생일 월, 생일 일 을 구분해서 출력하세요.
select * FROM student;

select 
    name as  이름,
    birthday 년도,
    birthday 월,
    birthday 일
FROM student;

select
    name as 이름,
    substr(jumin, 1,2) 년도,
    substr(birthday, 4,2) 월,
    substr(birthday, 7,2) "일"
from student;


--2.
--Student 테이블의 tel 컬럼을 사용하여 1 전공번호(deptno1)가 201번인
--학생의 이름과 전화번호, ‘)‘ 가 나오는 위치를 출력하세요.

select * from student;

-- INSTR(대상값|컬럼명, 찾는값)
-- INSTR(대상값|컬럼명, 찾는값, 시작위치)
-- INSTR(대상값|컬럼명, 찾는값, 시작위치, 몇번째값)

select
    name,
    tel,
    deptno1
from student;


select name, tel,
    instr(tel, ')') 괄호위치
from student
where deptno1 = 201;



--3.
--Student 테이블에서 1 전공이 101번인 학생들의 tel 컬럼을 조회하여
-- 3 이 첫 번째로 나오는 위치를 이름과 전화번호와 함께 출력하세요.
select * from student;

select name, tel,
-- instr(tel, '3') 첫3위치
    instr (tel, '3', 1, 1) 첫3위치
from student
where deptno1 = 101;


--4.
Student 테이블을 참조해서 아래 화면과 같이 1 전공이(deptno1 컬럼) 201번인
학생의 이름과 전화번호와 지역번호를 출력하세요.
단 지역번호는 숫자만 나와야 합니다.

--REPLACE(기준값, 찾는대상, 바꿀값)
select name, tel,
    replace(substr(tel, 1,3), ')', '') 지역번호
    from student
where deptno1 = 201;

select name, tel,
    substr(tel, 1,3) 지역번호,
    instr(tel, ')')             -- INSTR(대상값|컬럼명, 찾는값)
    from student
where deptno1 = 201;

select name, tel,
                -- INSTR(대상값|컬럼명, 찾는값, 시작위치)
    substr(tel, 1, instr(tel, ')') -1) 지역번호
    from student
where deptno1 = 201;