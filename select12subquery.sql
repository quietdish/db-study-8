/**-------------------------------**/
서브쿼리
;


select
    rownum,
    CEIL(rownum /3),
    studno,
    name
from student;



select
    rownum,
    CEIL(rownum /3),
    studno,
    name,
    height
from student
order by height;

select *
from (
        select
            rownum,
            CEIL(rownum /3),
            studno,
            name,
            height
        from student
        order by height
        );
        
        
select rownum, studno, name, height     --- 로우넘 정렬됨...
from (
        select
            rownum,
            CEIL(rownum /3),
            studno,
            name,
            height
        from student
        order by height
        );
        
        
select rownum, rn, studno, name, height     -- AVG(Pay)
from (
        select
            rownum rn,                     -- AVG(Pay)
            CEIL(rownum /3),
            studno,
            name,
            height
        from student
        order by height
        );
        

select *
from student
where rownum <= 5;      --그냥 조회 결과 5명

--키큰 사람 5명 조회 키순?
select *
from student
order by height desc;

select *
from student            -- 기존배정된 rownum 으로 인식 -> 정렬 이후 rownum 과 다름
where rownum <= 5       ---ㄴㄴ 로우넘이 정렬하면서 꼬여서 안됨...
order by height desc;

select rownum, s.*
from student s;

select rownum, s.*
from student s
order by height desc;



select *
from student s
order by height desc;

select *
from (
        select *
        from student s
        order by height desc
        );
        

select rownum, studno, name, height
from (
        select *
        from student s
        order by height desc
        );
        
select rownum, studno, name, height
from (
        select *
        from student s
        order by height desc
        )
where rownum <= 5;                  ---상위 5명 뽑힘..





--팀 번호로 팀 조회
select
    rownum,
    CEIL(rownum /3),
    studno,
    name
from student                        ---여기까지만 드래그해야 출력이 되긴됨..-,.-
where CEIL(rownum /3) = 3;

select *
from (
    select
        rownum,
        CEIL(rownum /3),
        studno,
        name
    from student
)
where CEIL(rownum /3) = 3;          -- 인식 제대로 안됨


select *
from (
    select
        rownum rn,
        CEIL(rownum /3) team,
        studno,
        name
    from student
)
where team = 3;



/*-------------------------------------*/
group by 집계 -> subquery,    join

select * from emp;

--부서별 최대급여
select deptno, max(sal)
from emp
group by deptno;

select deptno, max(sal), ename      ---그룹바이에 ename 없어서 오류...
from emp                            --집계 결과 + 일반 컬럼 값 동시에 표현하기 힘듦
group by deptno, ename;             --집계 기준으로 활용여부 -> 목적에 맞는 그룹화가 아님


select deptno, max(sal)
from emp
group by deptno;                    ---프롬 테이블로 쓴대~..


--직원 테이블 조회 데이터에 옆에 해당 부서의 최대 급여 표시
select *
from emp A, (select deptno, max(sal) max_sal
                from emp
                group by deptno) B
where A.deptno = B.deptno              
;


--부서별 최대 급여 + 부서명
select deptno, max(sal)
from emp
group by deptno;

select * 
from dept d, (select deptno, max(sal) max_sal
                        from emp
                        group by deptno) e
WHERE d.deptno = e.deptno;                        

select e.deptno, d.dname, e.max_sal
from dept d, (select deptno, max(sal) max_sal
                from emp
                group by deptno) e
WHERE d.deptno = e.deptno; 




select deptno, max(sal)
from emp
group by deptno;

select deptno, max(sal), (select dname from dept where deptno = e.deptno)
from emp e
group by deptno;


select *
from (select deptno, max(sal) max_sal
    from emp
    group by deptno) e;


select deptno, max_sal, (select dname from dept where deptno = e.deptno)
from
 (select deptno, max(sal) max_sal
    from emp
    group by deptno) e;
    
    
    
    

select *
from emp e, dept d
where e.deptno = d.deptno;

select e.deptno, e.sal, d.dname
from emp e, dept d
where e.deptno = d.deptno;

select deptno, dname, max(sal)
from(
    select e.deptno, e.sal, d.dname
    from emp e, dept d
    where e.deptno = d.deptno
    )
group by deptno, dname;