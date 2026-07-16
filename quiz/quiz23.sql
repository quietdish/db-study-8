사전준비.
CREATE TABLE temp_professor
AS
SELECT * FROM professor;

SELECT * FROM temp_professor;    ---16행

1.
temp_professor 테이블에서 직급이 조교수(assistant professor) 인 교수들의
BONUS 를 200 만원으로 인상하세요.
update temp_professor
set bonus = 200
--SELECT * FROM temp_professor;
where position = 'assistant professor';

--update professor2
--set bonus = 200
--where profno = 100;


2.
temp_professor 테이블에서 'Sharon Stone' 교수의 직급과 동일한 직급을 가진
교수들 중 현재 급여가 250 만원이 안 되는 교수들의 급여를 15% 인상하세요.

select *
from temp_professor
where position = (select position
                    from temp_professor
                    where name = 'Sharon Stone')
and pay < 250;

select 
    pay,
    pay*15/100,
    pay*0.15,
    pay + pay*0.15,
    pay*1.15
from temp_professor
where position = (select position
                    from temp_professor
                    where name = 'Sharon Stone')
and pay < 250;


update temp_professor
set pay = pay*1.15
-- select * from temp_professor
where position = (select position
                    from temp_professor
                    where name = 'Sharon Stone')
and pay < 250;                    


select * from temp_professor;

--select * from temp_professor;
--
--update temp_professor
--set pay = pay + (pay * 0.15)
--    select *
--        from temp_professor
--        (where position = (select *
--                            from temp_professor
--                            where name = 'Sharon Stone'
--                        ))
--        where pay < 250
--        ;
