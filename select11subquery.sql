/*********---------------------------*/
서브쿼리 (Sub-Query)

select (쿼리: 스칼라 서브쿼리)
from   (쿼리: 인라인 뷰)
where  (쿼리: 서브쿼리)
;

select * from emp;

20번 부서 사람들만 조회
select * from emp
where deptno = 20;

사번이 7844인 사원과 같은 부서(30) 사람들 조회

select * from emp
where deptno = 30;  --직접 데이터 확인 -> 부서번호 하드코딩

select * from emp
where deptno = (select deptno from emp
                where empno = 7844);        --- 30 => (ㄴㅇㄹㄴㅇㄹ)

select deptno from emp       --7844사번을 가진 사원의 부서번호
where empno = 7844;





------------------
select * from emp2;     --deptno
select * from dept2;    --dcode

포항 사무실(d.area)에서 일하는 직원 목록 조회
select * from dept2
where area = 'Pohang Main Office';

-- join
select * 
from emp2 e, dept2 d
where e.deptno = d.dcode
and d.area = 'Pohang Main Office';

-- 서브쿼리
select * 
from emp2
where deptno = (select dcode 
                from dept2
                where area = 'Pohang Main Office');      --오류

select * 
from emp2
where deptno in (select dcode 
                from dept2
                where area = 'Pohang Main Office');
                
in ('0001', '1003', '1006', '1007)


0001번팀을 제외하고 포항 사무실(d.area)에서 일하는 직원 목록 조회;

---01way
select * 
from emp2
where deptno in (select dcode 
                from dept2
                where area = 'Pohang Main Office'
                and dcode <> '0001');
                
---02way
select * 
from emp2
where deptno in (select dcode 
                from dept2
                where area = 'Pohang Main Office')
and deptno <> '0001';               



---
select * 
from emp2
where deptno in (select dcode 
                from dept2
                where area = 'Pohang Main Office'
                and dcode = '0001');
                
-------------------------------------------                
select * 
from emp2
where deptno in (select dcode 
                from dept2
                where area = 'Pohang Main Office'
                and dcode = deptno);
                
select * 
from emp2
where exists (select dcode                      ---exists --빠르대~~
                from dept2
                where area = 'Pohang Main Office'
                and dcode = deptno);

select * 
from emp2 e2
where exists (select dcode 
                from dept2
                where area = 'Pohang Main Office'
                and dcode = e2.deptno);

---
            select dcode 
                from dept2
                where area = 'Pohang Main Office'
                and dcode = '1002';


-----------------------------------------
학생 student

> 학번 9513 학생보다 키 작은 학생들 조회

select *
from student
where height < (9513키);     --

select *
from student
where height < (select height
                from student
                where studno = 9513);

select * 
from student;
where studno = 9513;

> 2학년 학생들 기준 제일 많은 몸무게보다 (2학년 학생중 제일 무거운 학생의 몸무게보다)
    전체 학생들 중에서 더 많은 몸무게 나가는 학생 목록 조회

select *
from student
where weight > (2학년최대);     --

select *
from student
where weight > (select MAX(weight)
                from student
                where grade = 2);       ---83kg

select MAX(weight)
from student
where grade = 2;                        ---82kg

---- 각 학년별로 가장 큰 몸무게
select *
from student
where weight >
;

select MAX(weight)
from student;   --83kg

select MAX(weight)
from student
group by grade;     --4개

select *
from student
where weight < any (select MAX(weight)
                    from student
                    group by grade)
;
    any all
    
    < any 83         ( 81   82  83  58 )      --아무거나라도 작으면됨..?
    < all 58                                    --최대값보다 작아야..?
    > any 58
    > all 83
    




>> 단일행 비교   =   in
>> 다중행 비교   in, not in, >any all
>> 다중컬럼 비교  (컬럼수를 맞춰서 비교)
    
---- 각 학년별로 가장 큰 몸무게

--  학년, 몸무게
select grade, MAX(weight)
from student
group by grade;

select * 
from student in(   -- 몸무게만 비교하면, 학년별 최대 몸무게 학생 추출에 문제발생 가능성 있음
                select MAX(weight)
                from student
                group by grade);        -- 오류

---
select * 
from student;

---- 각 학년별로 가장 큰 몸무게

select * 
from student
where (grade, weight) in (select grade, MAX(weight)
                            from student
                            group by grade);
                            
                            
--emp2 기준 전체 평균급여보다 많이 받는 직원 조회----
select *
from emp2;

select avg(pay)
from emp2;

select *
from emp2
where pay > (select avg(pay)        ---43100000
            from emp2);
            
--emp2 기준   각자, 자신과 같은 직급(position)의 평균 급여보다 많이 받는 직원 조회

select position
from emp2;

select *
from emp2
--where name = 'AL Pacino';
where empno = 19960101;

select position
from emp2
--where name = 'AL Pacino';
where empno = 19960101;         ---Department head

select avg(pay)
from emp2
where position = (
                select position
                from emp2
                --where name = 'AL Pacino';
                where empno = 19960101);
                
--emp2 기준   각자, 자신과 같은 직급(position)의 평균 급여보다 많이 받는 직원 조회

select *
from emp2;

select *
from emp2
where pay > (평균
            select avg(pay)
            from emp2
            where position = 현재비교하는 대상 position
            )
            
select *
from emp2
where pay > (평균
            select avg(pay)
            from emp2
            where position = position
            --where position = 현재비교하는 대상 position
            )
            
select *
from emp2 A
where pay > ( --평균
            select avg(pay)
            from emp2 B
            where B.position = A.position
            --where position = 현재비교하는 대상 position
            )
            ---드래그해서 출력
            
select *
from emp2;

select avg(pay)
            from emp2 B
            where B.position = 'Section head';  ---A.position.. 51500000
            
            
----emp2 기준 자신과 같은 고용형태(emp_type)의 평균 급여보다 적게 받는 직원목록 조회.

select *
from emp2
where pa < 평균급여

select *
from emp2
where pay < (emptype 같은 평균급여
            select avg(pay)
            from emp2
            where emp_type = ;
            
select *
from emp2 A
where pay < ( --emptype 같은 평균급여
            select avg(pay)
            from emp2 B
            where B.emp_type = A.emp_type);
            
            
            
            
            
/******************************************/
select * from emp2;     --name
select * from dept2;    --d.name dcode

사원이름 부서번호 부서이름

--join
select * 
from emp2 e, dept2 d
where e.deptno = d.dcode;

select e.name, e.deptno, d.dname
from emp2 e, dept2 d
where e.deptno = d.dcode;


--subquery
select
    e.name,
    e.deptno,
    
from emp2 e;

select dname
from dept2
where dcode = '1007';

select
    e.name,
    e.deptno,
    (select dname
    from dept2
    where dcode = '1007') dname
from emp2 e;

select
    e.name,
    e.deptno,
    (select dname
    from dept2
    where dcode = e.deptno) dname
from emp2 e;

select dname
from dept2
where dcode = '1007';


select * from panmae;
select * from product;

--join
select *
from panmae A, product B
where A.p_code = B.P_code;

select
    A.p_date,
    A.p_code,
    B.p_name
from panmae A, product B
where A.p_code = B.P_code;      --21개

--subquery
select 
    a.p_date,
    a. p_code,
    (select p_name
        from product
        where p_code = 102) 상품명     --21개
from panmae A;

select p_name
from product
where p_code = 102;

select 
    a.p_date,
    a. p_code,
    (select p_name
        from product
        where p_code = a.p_code) 상품명    --21개
from panmae A;





/*******************************************************/

select *
from emp;

select job, mgr, sal, comm, deptno
from emp;


select empno, ename, job
from emp;

--- 프롬안에 (ㅇㅅㅇ).....
select *    --sal from 절에 속해있는 select 결과를 테이블(뷰)로 간주
from (
    select empno, ename, job
    from emp )
;

select empno, ename, job
from (
    select empno, ename, job
    from emp )
;

select empno, ename, job
from (
    select 
        empno enum, 
        ename emp_name, 
        job jjb
    from emp )
;

--select empno, ename, job
select *
from (
    select 
        empno enum, 
        ename emp_name, 
        job jjb
    from emp )
;

--select empno, ename, job
select enum, emp_name, jjb
from (
    select      -- 컬럼 별칭을 설정하면 외부에서 조회시 기본 컬럼명으로 인식
        empno enum, 
        ename emp_name, 
        job jjb
    from emp )
;

select *
from (
    select e.empno, e.name, e.deptno, d.dname
    from emp2 e, dept2 d
    where e.deptno = d.dcode);





----emp2 기준 자신과 같은 고용형태(emp_type)의 평균 급여보다 적게 받는 직원목록 조회.
select *
from emp2 A
where pay < ( --emptype 같은 평균급여
            select avg(pay)
            from emp2 B
            where B.emp_type = A.emp_type);          ---위에서 한거...
            

select emp_type, avg(pay)
from emp2
group by emp_type;


select *
from (
    select emp_type, avg(pay)
    from emp2
    group by emp_type
    );

--select avg(pay)   --함수로 인식되서 컬럼선택 불가
select *
from (
    select emp_type, avg(pay) avg_pay
    from emp2
    group by emp_type
    );
    
select emp_type, avg_pay
from (
    select emp_type, avg(pay) avg_pay
    from emp2
    group by emp_type
    );
    


select *                                    ---20개
from 
    emp2 A, (
            select emp_type, avg(pay) avg_pay
            from emp2
            group by emp_type
            ) B
where A.emp_type = B.emp_type;


select *                                    ---6개
from 
    emp2 A, (
            select emp_type, avg(pay) avg_pay
            from emp2
            group by emp_type
            ) B
where A.emp_type = B.emp_type
and A.pay < B.avg_pay;


select *
from 
    emp2 A, (
            select emp_type, trunk(avg(pay)) avg_pay    ---??????????
            from emp2
            group by emp_type
            ) B
where A.emp_type = B.emp_type
and A.pay < B.avg_pay;

