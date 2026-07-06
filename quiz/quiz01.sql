--1.

select * from student;
--  NAME    ID  WEIGHT
select NAME, ID, WEIGHT from student;

SELECT
    NAME || '''s ID : ' || id
    || ', WEIGHT is ' || weight || 'Kg' "ID AND WEIGHT"
FROM student;

--SELECT 
--    WEIGHT AS "ID AND WEIGHT",
--FROM student;

--SELECT
--    WEIGHT name,
--    WEIGHT ID,
--    WEIGHT WEIGHT
--from STUDENT;


--2.
SELECT * FROM EMP;

SELECT 
    ENAME,
    JOB
FROM EMP;


SELECT * FROM EMP;
select 
    ename,
    sal
from emp;

SELECT ENAME || '(' || JOB || ') , ' || ENAME || '''' || JOB || '''' "NAME AND JOB"
FROM EMP;


--3.
SELECT * FROM EMP;

select ename || '''s sal is $' || sal "Name and Sal"
from emp;
