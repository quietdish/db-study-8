/*------------------------------------*/
DML MERGE 데이터 병합




--신발가게 날짜별 매출
CREATE TABLE T_SHOE
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK) (10, 20, 30, 40 ..)
    sales_income NUMBER(10) --매출금액  
);

--옷가게 날짜별 매출
CREATE TABLE T_CLOTH
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK) (1,2,3,4...)
    sales_income NUMBER(10) --매출금액  
);


--본사 날짜별 전체 매출 취합
CREATE TABLE T_COMPANY
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK)
    sales_income NUMBER(10) --매출금액  
);

INSERT ALL
INTO T_SHOE VALUES (TO_DATE('2025-03-01'), 1, 5000)
INTO T_SHOE VALUES (TO_DATE('2025-03-02'), 1, 15000)
INTO T_SHOE VALUES (TO_DATE('2025-03-03'), 1, 30000)
INTO T_SHOE VALUES (TO_DATE('2025-03-02'), 2, 4000)
INTO T_SHOE VALUES (TO_DATE('2025-03-03'), 2, 90000)
INTO T_SHOE VALUES (TO_DATE('2025-03-04'), 2, 120000)
INTO T_SHOE VALUES (TO_DATE('2025-03-04'), 1, 90000)
select * from dual;


SELECT *
--DELETE
FROM T_SHOE WHERE work_date = '2025-03-07';

INSERT ALL
INTO T_CLOTH VALUES (TO_DATE('2025-03-01'), 10, 59000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-02'), 10, 25000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-03'), 10, 33000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-04'), 20, 4400)
INTO T_CLOTH VALUES (TO_DATE('2025-03-05'), 20, 99000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-06'), 20, 790000)
select * from dual;

select * 
from t_cloth;



select *
from t_shoe;


매출정보 >>> t_company 전체 데이터 취합 (병합)


insert into t_company
select * from t_shoe;

select * from t_company;

--insert into t_company
--select * from t_cloth;
insert into t_company
select work_date, store_code, sales_income from t_cloth;

---가게별 일자별 취합...

select store_code, sum(sales_income)
from t_company
group by store_code;

select work_date, sum(sales_income)
from t_company
group by work_date
order by work_date;


-------------------------------
배치처리 (batch) 주기적으로 특정 시점, 시간 수행

주기적으로 취합
데이터가 발생 -> 배치시작 새벽 2시 ---

select * 
from t_shoe;
select * 
from t_cloth;
select * 
from t_company;


--취합 이후에 추가된 데이터 처리 시나리오를 위한 데이터 추가
INSERT INTO T_SHOE VALUES (TO_DATE('2025-03-07'), 1, 210000);

--취합 이후에 수정된 데이터 처리 시나리오를 위한 데이터 수정
UPDATE T_CLOTH
SET sales_income = 890000
WHERE work_date = '2025-03-06'
AND store_code = 20;

---취합........


--3월 8일 추가를 하드코딩 손으로 직접
insert into t_company
select * from t_shoe
where work_date = '2025-03-07';

--임시 시나리오 가정
--데이터가 밤 22~24시 저장(어제)
--배치시작 새벽 2시 (오늘)
select *
from t_shoe
where to_char(work_date, 'yyyymmdd') = to_char(sysdate-1, 'yyyymmdd');

select *
from t_shoe
--where to_char(work_date, 'yyyymmdd') = to_char(sysdate-1, 'yyyymmdd');
where to_char(work_date, 'yyyymmdd') = to_char(to_date('2025-03-08')-1, 'yyyymmdd');



1) delete -> 다시 전부 insert ---편법 ㅋㅋ

select * 
from t_shoe;
select * 
from t_cloth;
select * 
from t_company;

delete from t_company;
insert into t_company select * from t_shoe;
insert into t_company select * from t_cloth;


2) merge

merge into 저장대상 테이블명(최종취합)
using 데이터를 가져올 테이블명
on (병합/비교 기준조건)
when matched then   --합치려는 데이터가 기존에 있을때
    update set      --수정
    delete where    --삭제
when not matched then   --합치려는 데이터가 기존에 없을때
    insert values (...)   --추가
    
----------
select * 
from t_shoe;
select * 
from t_cloth;
select * 
from t_company;

------- 테스트 벙합전 기존 데이터 삭제 (드래그실행...)
select *
--delete
from t_company;


merge into t_company A
using t_shoe B
on (A.work_date = B.work_date)
when matched then
    update set A.sales_income = B.sales_income
when not matched then
    insert values (B.work_date, B.store_code, B.sales_income);
    
    
merge into t_company A
using t_cloth B                         --- 위에거 복사해서 이거만 수정 ㅎ..
on (A.work_date = B.work_date)
when matched then
    update set A.sales_income = B.sales_income
when not matched then
    insert values (B.work_date, B.store_code, B.sales_income);


select * 
from t_company;         ---9X ... 10개 됨..


--날짜 1개 기준으로 처리 -> 동일 날짜 겹침으로 데이터가 덮어쓰기 -> 정확한 병합이 불가능
--날짜 + 매장코드 -> 2개를 병합기준으로...

merge into t_company A
using t_shoe B
on (A.work_date = B.work_date and A.store_code = B.store_code)
when matched then
    update set A.sales_income = B.sales_income
when not matched then
    insert values (B.work_date, B.store_code, B.sales_income);
    
merge into t_company A
using t_cloth B                         --- 위에거(2뭉치) 복사해서 추가...
on (A.work_date = B.work_date and A.store_code = B.store_code)
when matched then
    update set A.sales_income = B.sales_income
when not matched then
    insert values (B.work_date, B.store_code, B.sales_income);
    
select * from t_company;


/*-----------------*/
전체 데이터 취합 테이블 t_company
날짜 + 매장코드 기준 조회

---가게별 일자별 취합... 80줄

select store_code, sum(sales_income)
from t_company
group by store_code;

select work_date, sum(sales_income)
from t_company
group by work_date
order by work_date;


select * from t_company;
--shoe 신발가게 매장 매출만 보고싶음.. t_shoe
select *
from t_company
where store_code in (
                    select store_code from t_shoe
                    )
                    
--shoe 신발가게 매장 매출만 보고싶음.. t_shoe
select *
from t_company
where store_code in (
                    select distinct(store_code)
                    from t_shoe
                    );


--매장 판매유형 구분 코드 컬럼 추가한 버전 테이블

CREATE TABLE T_COMPANY_type
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK)
    sales_income NUMBER(10), --매출금액  
    store_type varchar2(8)  --매장 유형 구분 코드   'C' 옷가게, 'S' 신발가게
);


merge into t_company_type A     ---_type 추가..
using t_shoe B
on (A.work_date = B.work_date and A.store_code = B.store_code)
when matched then
    update set A.sales_income = B.sales_income
when not matched then           --신발 정보 삽입할때, store_type을 'S'로 저장
    insert values (B.work_date, B.store_code, B.sales_income, 'S');
    
merge into t_company_type A     ---_type 추가..
using t_cloth B                         --- 위에거(2뭉치) 복사해서 추가...
on (A.work_date = B.work_date and A.store_code = B.store_code)
when matched then
    update set A.sales_income = B.sales_income
when not matched then                                       ---'C'
    insert values (B.work_date, B.store_code, B.sales_income, 'C');
    
select * 
from t_company_type;
 
select * 
from t_company_type
where store_type = 'S';

select store_type, sum(sales_income)
from t_company_type
group by store_type;

select store_type, store_code, sum(sales_income)
from t_company_type
group by store_type, store_code
order by store_type, store_code;

select store_type, store_code, sum(sales_income)
from t_company_type
group by rollup(store_type, store_code);


select * from t_company_type;