1. 다음 두 명령어는 어떤 기능을 수행하는 명령어인지 작성하고,
두 기능의 차이점이 있다면 설명하시오.
DELETE FROM 테이블명;       테이블 행(데이터) 삭제
TRUNCATE TABLE 테이블명;    테이블 내부 데이터 포맷(초기화)

--데이터 삭제, dml, 조건에 따라서 원하는 데이터만 삭제 (where 조건), 수행 후 commit/rollback 기회
--데이터 삭제, ddl, 테이블 전체 삭제(초기화), 삭제쿼리 실행시 바로 적용(auto commit)
drop table : 테이블 자체를 삭제


2. 다음 조건에 따라 테이블을 생성하시오.
테이블명 : T_MEMBER_POINT
*내부 컬럼
ID : 숫자형 6자리
순번 : 숫자형 6자리
멤버ID : 문자형 24바이트, Null 안됨(꼭 입력해야함)
점수 : 숫자형 3자리
채점일시 : 날짜형, 단 입력된 값이 없을 경우 입력(현재)시간을 기본값으로 설정
※ 기본키(PK) : ID와 순번의 조합

create table t_member_point
(
    id number(6),
    no number(6),
    member_id varchar2(24) not null,
    point number(3),
    check_date date default sysdate,
    constraint t_member_point_pk primary key (id, no)
);

--drop table t_member_point; 테이블 자체 삭제
select * from t_member_point;


3. 다음 조건에 맞는 시퀀스를 생성하시오. -> 생성한 시퀀스는 id 컬럼에 사용
시퀀스명 : T_MEMBER_POINT_PK_SEQ
*상세조건
1부터 시작하며 1씩 증가한다.
값의 범위는 1~999999
순환하지 않도록 한다.

create sequence T_MEMBER_POINT_PK_SEQ
increment by 1
start with 1
minvalue 1
maxvalue 999999
nocycle;


4. 생성한 시퀀스의 값을 불러서 임의의 데이터를 저장해보시오.
(*순번은 각 멤버ID 별로 자동 계산되어 저장하도록 해주세요)
- 시퀀스 사용 -> id
- 순번(no) -> 해당 학생이 시험을 치룬 회차 계산되서 저장
--

* 저장시 필요한 데이터가 파라미터로 전달되는 것으로 가정
저장하는 데이터 예시)
ID: 자동, 순번: 멤버ID에 따라 자동, 멤버ID : A, 점수: 30, 채점일시:입력or현재
ID: 자동, 순번: 멤버ID에 따라 자동, 멤버ID : B, 점수: 40, 채점일시:입력or현재
ID: 자동, 순번: 멤버ID에 따라 자동, 멤버ID : C, 점수: 40, 채점일시:입력or현재
ID: 자동, 순번: 멤버ID에 따라 자동, 멤버ID : A, 점수: 50, 채점일시:입력or현재
ID: 자동, 순번: 멤버ID에 따라 자동, 멤버ID : B, 점수: 60, 채점일시:입력or현재
ID: 자동, 순번: 멤버ID에 따라 자동, 멤버ID : A, 점수: 70, 채점일시:입력or현재

저장된 예시
ID: 1, 순번: 1, 멤버ID : A, 점수: 30, 채점일시:입력or현재
ID: 2, 순번: 1, 멤버ID : B, 점수: 40, 채점일시:입력or현재
ID: 3, 순번: 1, 멤버ID : C, 점수: 40, 채점일시:입력or현재
ID: 4, 순번: 2, 멤버ID : A, 점수: 50, 채점일시:입력or현재
ID: 5, 순번: 2, 멤버ID : B, 점수: 60, 채점일시:입력or현재
ID: 6, 순번: 3, 멤버ID : A, 점수: 70, 채점일시:입력or현재

select count(*)+1
from t_member_point
where member_id = 'A';

select nvl(max(no), 0)+1
from t_member_point
where member_id = 'A';

insert into t_member_point values (T_MEMBER_POINT_PK_SEQ.nextval, no, 'A', 30, sysdate);


