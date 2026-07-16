사전준비.
CREATE TABLE temp_dept2
AS
SELECT * FROM dept2;

1. temp_dept2 테이블에 아래와 같은 내용으로 새로운 부서정보를 입력하세요.
* 부서번호 : 9010
* 부서명 : temp_10
* 상위부서 : 1006
* 지역 : temp area

SELECT * FROM temp_dept2;

insert into temp_dept2
values ( 9010, 'temp_10', 1006, 'temp area' );





2. temp_dept2 테이블에 아래와 같은 내용으로 특정컬럼에만 정보를 입력하세요
* 부서번호 : 9020
* 부서명 : temp_20
* 상위부서 : Business Department ( 1006 번 부서 )

insert into temp_dept2 (dcode, dname, pdept)    --area
values ( 9020, 'temp_20', '1006');

insert into temp_dept2 --(dcode, dname, pdept)
values ( 9020, 'temp_20', '1006', null);

--insert into new_table1 (no, name, birth)
--values ( 1, '이름1', sysdate);

SELECT * FROM temp_dept2;



3. professor 테이블에서 profno 가 3000 번 이하의 교수들의 
profno , name , pay, bonus 를 가져와서 새로운 new_professor 테이블을 생성하면서 
데이터 한번에 넘겨지며 저장하는 쿼리를 쓰세요.
--CREATE TABLE new_professor
--AS
--SELECT * FROM professor
--where profno <= 3000;

CREATE TABLE new_professor
AS
SELECT profno , name , pay, bonus from professor
where profno <= 3000;

--drop table new_professor;

SELECT * FROM new_professor;

---insert into new_professor
---values ( '9020', 'temp_20', '1006');



4. new_professor 테이블에서 'Winona Ryder' 교수의 BONUS 를 
100 만원으로 인상하세요.

SELECT * FROM new_professor
where name = 'Winona Ryder';

update new_professor
set bonus = 100
where name = 'Winona Ryder';


SELECT * FROM new_professor;
--update new_professor
--set bonus = NVL(bonus, 0) + 100     -- null 이면 0으로 간주   0+200 = 200 증가
--where name = 'Winona Ryder';
        
--set bonus = bonus + 100
--select * from professor2
--where bonus is not null;