/****************************************/
DDL 테이블 제약조건


-- default : 저장되는 값이 없을때 저장될 기본값

create table new_table3
(
    no number(3) default 1,     --숫자형 3자리수
    name varchar2(16) default 'noname',    --문자형 16바이트
    birth date default sysdate  --날짜형
);

insert into new_table3
values( 1, 'name1', to_date('2020-01-01'));

select * from new_table3;

insert into new_table3
values( 2, null, to_date('2020-01-02'));    --null 이라는 값을 지정해서 저장 (디폴트로 ㄴㄴ)

insert into new_table3 (no, birth)
values( 3, to_date('2020-01-03'));

insert into new_table3 (name, birth)
values( 'name4', to_date('2020-01-04'));

insert into new_table3 (no, name)
values( 5, 'name5');


commit;
select * from new_table3;



/*-----------------------------------------*/

unique : 중복되지 않는 유일한 값
not null : null 값 저장 불가 (Nullable No)

무결성
( db 가장 기본 내용일 뿐.. : 중복X + NOT NULL ) 
: 데이터 올바르게 , 일관되게, 유지

    > 정확성 : 실제 값 올바르게 저장
            키 저장 172.4 -> 1724         X
            생일 1995-10-30 -> 1995-20-30 X
    > 일관성 : 같은 의미 데이터는 일관된 값 (데이터가 동일)
            식당 포스기 : 15,000원
            키오스크 주문내역 : 13,000원     X....
    > 완전성 : 필요 데이터가 존재해야함..
            회원가입시 전화번호 인증 필수 : 전화번호 = null    X....
            배달주문 메뉴내역 존재, 주문자정보 없으면 잘못된거.. : 필수인 주문자 정보가 없다!
    > 신뢰성 : 데이터에 대한 믿음 신뢰
            계좌 잔액 10만원 확인했는데  -> 잔액 조회 시 계산 오류로 8만원 표시 X
            신발 구매 재고확인 1개 -> 창고에 가지러 갔더니 0개                X

check : 저장 가능한 범위 설정

--------------------------------------
create table T1
(
    no number(3) UNIQUE,
    name varchar2(16) NOT NULL,
    birth DATE
);                             --- 드래그해서 실행 -ㅂ-~~..

select * from t1;

insert into t1
values (1, 'name1', sysdate);

insert into t1
values (2, null, sysdate);      -- 오류! not null 제약 name 컬럼에 null 저장하려고 함 -> XXX

insert into t1
values (2, 'name2', sysdate);

commit;
select * from t1;


insert into t1
values (2, 'name3', sysdate);   -- UNIQUE 제약 NO 컬럼 값이 중복됨 -> XXX 2번 이미 있어 ㅇㅅㅇ..

insert into t1
values (3, 'name3', sysdate);   -- 중복값 아니면 정상 저장됨..


insert into t1 (no, birth)      -- 생략한 name 컬럼에는 null 값이 저장될 예정
values (4, sysdate);            --- 오류.! name NOT NULL  저장 XXX

insert into t1 (name, birth)    -- 생략한 no 컬럼에는 null 저장됨..
values ('name4', sysdate);      --no UNIQUE 중복된 값 제한O    null 저장은 가능

select * from t1;
commit;

-----------------------------------------------

create table T2
(
    no number(3) constraint T2_NO_UNIQUE UNIQUE,    -- constraint 제약이름 제약속성
    name VARCHAR2(16) CONSTRAINT T2_NAME_NOTNULL NOT NULL,
    birth DATE,
    score NUMBER(3) CONSTRAINT T2_SCORE_CHECK CHECK (score BETWEEN 0 AND 100),
    pass VARCHAR2(2) CONSTRAINT T2_PASS_CHECK CHECK (pass IN ('Y', 'N'))
);

OracleDB 데이터타입
숫자/문자/날짜
number/varchar2/date

number(자리수)
number(3) : 3자리수
number(6) : 6자리수

number(전체자리수, 소수점자리수)
number(6,3) : 전체자리수 6자리, 소수점 3자리
                123.456 O   10.551 O    1234.56 X <- number(7,3)

number 만 표기 : 38자리수 ---()없이..

varchar2(바이트수)
varchar2(6) : 6바이트 6자리글자X   한글 한글자 3byte -> 한글기준 2글자
---varchar
---varchar2 <- 이거 쓰면됨 -,.-

DATE / TIMESTAMP

BOOLEAN True/False
    'True' / 'False'
    'y' / 'n'
    't' / 'f'       where 컬럼 = 't'
    1 / 0

v23 이후...
BOOLEAN 제공 시작함...
컬럼명 boolean
데이터값 true / false

---------------------------------------------------------------

insert into t2
values (1, 'name1', sysdate, 60, 'Y');  --중복 제약 위배

select * from T2;

insert into t2
values (2, null, sysdate, 60, 'Y');     -- 이름 not null 제약 위배

insert into t2
values (2, 'name2', sysdate, 160, 'Y');     -- score 점수범위 (0~100) 제약 위배

insert into t2
values (2, 'name2', sysdate, 70, 'Y');