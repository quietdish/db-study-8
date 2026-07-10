select * from emp2;
/* emp2 테이블을 기준으로 아래 정보를 출력
사원들 중에 **70년대 생**이면서 지역번호를 기준으로 **서울(02),
**경기도(031)에 거주하는 사원들의 정보를 아래와 같이 출력하시오.
사번, 이름, 생년월일, 취미, 급여(pay), 성과급(급여의 150%)
, 직원분류(단, 가족과 같은 직원이라서 family로 표기)
[※뒤쪽 문구를 family 로 변경],
전화번호, 급여수준 (단, 급여수준은 아래와 같이 분류)
3500만 1원 ~ 4500만 : '하', 4500만 1원 ~ 6천만 : '중",
6000만 1원 이상 : '상', 그 외... : '화이팅' */

select 
    birthday,
    to_char(birthday, 'yy')
from emp2
--where to_char(birthday, 'yy') in ('70', '71', ...);
--where to_char(birthday, 'yy') between 70 and 79;
--where to_number (to_char(birthday, 'yy')) between 70 and 79;
where substr (to_char(birthday, 'yy'), 1, 1) = 7;


select 
    tel,
    substr(tel, 1, (instr(tel, ')') - 1))
from emp2
where substr(tel, 1, (instr(tel, ')') - 1)) in ('02', '031');


--------------------------
select * from emp2;
--------------------------
select 
    empno 사번, 
    name 이름,
    birthday 생년월일,
    hobby 취미, 
    pay 급여,
    pay*1.5 성과급,
    --emp_type 직원분류,
    substr(emp_type, 1, instr(emp_type, ' ')) || 'family' 직원분류,
    --substr(emp_type, instr(emp_type, ' ')+1) 직원
    --replace(emp_type, substr(emp_type, instr(emp_type, ' ')+1), 'family') 직원분류2,
    tel,
    case
        when pay between 35000001 and 45000000 then '하'
        when pay between 45000001 and 60000000 then '중'
        when pay >= 60000001 then '상'
        else '화이팅'
    end 급여수준
from emp2
where substr (to_char(birthday, 'yy'), 1, 1) = '7'
    and substr(tel, 1, instr(tel, ')')-1) in ('02', '031');



/*-----------------------------------------------------------------------*/
select
    empno 사번, name 이름,
    birthday 생년월일, hobby 취미, pay 급여,
    position 직원분류, tel
from emp2;


-----------망-----------
select
    empno 사번, name 이름,
    birthday 생년월일, hobby 취미, pay 급여,
    position 직원분류,
    decode( substr(tel, 1, 3), '02)', '서울') TEL,
    substr(tel, 1, (instr(tel, ')') - 1)),
from emp2
where SUBSTR(birthday, 1, 1) = 7;       --리스크 있다고 쓰지말래~


--group by empno
--having ((SUBSTR(birthday, 1, 2)) >= 70;)
    
--SUBSTR(대상값|컬럼명, 시작지점(1~), 자릿수)
    