/*---------------------------------*/
시퀀스 (Sequence)

순차적으로 값을 사용하는 용도 (번호표)
                (다른 DB auto increment ..)
                
PK(기본키) 용으로 사용하거나 순차적인 데이터를 표현하기위해 사용하는 숫자 값
시퀀스를 호출 할 때마다 자동으로 증가


시퀀스 생성

create sequence 시퀀스명
increment by 1  --증가할 값
start with 1    --시작값
minvalue 1      --최소값
maxvalue 10     --최대값
cycle | nocycle --순환여부 default:nocycle
cache 20 | nocache  --숫자 메모리에 미리 저장해둘 갯수
;

시퀀스 삭제
drop sequence 시퀀스명

시퀀스 사용(호출)
시퀀스명.nextval 다음값 호출(사용)
시퀀스명.currval 현재값 확인

/*-------------------------------------*/

--PK 설정 / PK 활용

create table seq_test
(
    no number(6) primary key,
    name varchar2(32)
);

select * from seq_test;

수동으로 no(pk) 값 확인하고 처리
insert into seq_test values (1, '이름1');
insert into seq_test values (2, '이름2');

서브쿼리로 no 순번 값 계산으로 처리 (count)
select count(*) from seq_test;      --현재 갯수
select count(*)+1 from seq_test;    --다음 no값

insert into seq_test values ((select count(*)+1 from seq_test), '이름3');
insert into seq_test values ((select count(*)+1 from seq_test), '이름4');
insert into seq_test values ((select count(*)+1 from seq_test), '이름5');


-- 한명이 탈퇴 3번 사용자 탈퇴
select *
--delete
from seq_test
where no = 3;

select * from seq_test;

다음 사용자 가입 저장 -> PK 중복으로 저장 불가 케이스
insert into seq_test values ( (select count(*)+1 from seq_test), '이름6');

----------***
데이터 관리 기준이 어떻게 되느냐?
삭제(탈퇴) 어떻게 관리? 탈퇴하면:
    1) 데이터 행만? 삭제 (delete from ...) 문제생김... 카운트안됨..
    2) 삭제된 것 처럼 데이터(상태값)로 관리 ('Y', 'N', ... 'O', 'X' )
---------***    
     
서브쿼리로 no 순번 값 계산으로 처리 (max)

select * 
-- delete
from seq_test;

select max(no)  --현재 마지막으로 사용된 제일 큰 no 값
from seq_test;

select max(no)+1  -- 이 다음에 사용할 no 값
from seq_test;

select nvl(max(no), 0)+1  -- 이 다음에 사용할 no 값
from seq_test;

select nvl(max(no)+1, 1)  -- 이 다음에 사용할 no 값
from seq_test;

insert into seq_test values ((select nvl(max(no), 0)+1 from seq_test), '이름6');


시퀀스로 no순번값 처리

-- t_테이블명
-- V_뷰명
-- dept3_id_notnull

create sequence seq_seq_test_pks
increment by 1
start with 1;
--min / max/ cache / nocycle

select seq_seq_test_pks.nextval from dual;  
--다음 차례 seq 호출( 호출하는 순간 사용됨, 계속 진행~)
select seq_seq_test_pks.currval from dual;  --현재 시퀀스값 확인

select * 
-- delete
from seq_test;

--insert into seq_test values ((select nvl(max(no), 0)+1 from seq_test), '이름7');
insert into seq_test values (seq_seq_test_pks.nextval, '이름7');
insert into seq_test values (seq_seq_test_pks.nextval, '이름8');
insert into seq_test values (seq_seq_test_pks.nextval, '이름9');

select * from seq_test
order by no;


select * 
-- delete
from seq_test
where no = 4;

select * 
-- delete
from seq_test
where no = 11;

insert into seq_test values (seq_seq_test_pks.nextval, '이름10');
insert into seq_test values (seq_seq_test_pks.nextval, '이름1');

PK를 시퀀스로 사용
일반 숫자로 활용 ~ 99999999999999999999999
코드와 결합 'CL' || seq.nextval  CL1 CL2 CL3 CL4
          'SH' || seq.nextval  SH1 SH5 SH6 SH7
          

select * from seq_test
order by no;

시퀀스 값을 조정해서 다시 1부터 시작

1) 시퀀스 삭제 후 재생성
drop sequence seq_seq_test_pks;

create sequence seq_seq_test_pks
increment by 1
start with 1;

select seq_seq_test_pks.nextval from dual;


2) 다음 시퀀스 값 조정
--현재값 확인
select seq_seq_test_pks.currval from dual;
--이 다음에 다시 nextval 다음 값을 호출했을 때 1이 나오도록 만들기!

--0으로 바꾸기   , 그 다음에 +1  -> 1
--지금 27 기준

--값이 조정되는 기준을 변경
alter sequence seq_seq_test_pks increment by -27;
alter sequence seq_seq_test_pks minvalue 0;
--1회 호출해서 다음값 변경 (0으로 만들기)
select seq_seq_test_pks.nextval from dual;
--다시 1씩 증가하는 기준으로 설정 복구
alter sequence seq_seq_test_pks increment by 1;
--시퀀스 다시 사용
select seq_seq_test_pks.nextval from dual;

--------------------------------------------

create sequence seq_01
start with 1
increment by 1
minvalue 1
maxvalue 5
nocycle;

select seq_01.nextval from dual;

create sequence seq_02
start with 1
increment by 1
minvalue 1
maxvalue 5
cycle
cache 3;

select seq_02.nextval from dual;

create sequence seq_03
start with 100
increment by 5;

select seq_03.nextval from dual;
