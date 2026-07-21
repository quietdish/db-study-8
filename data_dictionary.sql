데이터 딕셔너리 (사전)
오라클 DB에 관련된 각종 정보를 확인할 수 있는 사전 (테이블)

접근 자료 구분
USER_   : 현재 로그인 사용자가 소유한 객체 정보
ALL_    : 현재 로그인 사용자가 볼 수 있는 모든 객체 정보
DBA_    : DB 관리자 계정에서 조회할 수 있는? 객체 정보

select * from user_tables;
select * from all_tables;   ---170행
select * from DBA_tables;   ---안나옴..

select * from user_views;
select * from user_sequences;
select * from user_objects;         ---76
select * from user_constraints;     ---87 제약
select * from user_cons_columns;    ---제약조건이 걸려있는 컬럼들
select * from user_indexes;
select * from user_ind_columns;

select * from all_users;
select * from user_ROLE_PRIVS;      ---권한 주는거?

--테이블 이름으로 조회시
select *
from tab
where tname like '%EMP%';
