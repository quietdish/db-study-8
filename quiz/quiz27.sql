--테이블 생성시, product_quiz 테이블명으로 생성

CREATE TABLE product_quiz
(
product_id INTEGER NOT NULL,
product_code VARCHAR(8) NOT NULL,
price INTEGER NOT NULL
);

INSERT INTO product_quiz VALUES (1, 'A1000011', 10000);
INSERT INTO product_quiz VALUES (2, 'A1000045', 9000);
INSERT INTO product_quiz VALUES (3, 'C3000002', 22000);
INSERT INTO product_quiz VALUES (4, 'C3000006', 15000);
INSERT INTO product_quiz VALUES (5, 'C3000010', 30000);
INSERT INTO product_quiz VALUES (6, 'K1000023', 17000);

select * from product_quiz;

select price, count(*)
from product_quiz
group by price;


가격대 별로 나눠서 -> 갯수 세기
15000 -> 10000 묶어야된다..!


1) 개별적으로 따로 숫자 계산 후 합치기
select *
from product_quiz
where price >= 0 and price < 10000;
--where price between 0 and 9999;

select 0 price_group, count(*) products
from product_quiz
where price between 0 and 9999
union all

select 10000, count(*)
from product_quiz
where price between 10000 and 19999
union all

select 20000, count(*)
from product_quiz
where price between 20000 and 29999
union all

select 30000, count(*)
from product_quiz
where price between 30000 and 39999;

2) 가격대 별로 나눠서 그룹지어 갯수세기


2-1) case when 범위 지정

select
    case
        when price between 0 and 9999 then 0
        when price between 10000 and 19999 then 10000
        when price between 20000 and 29999 then 20000
        when price between 30000 and 39999 then 30000
    end price_group,
    count(*) products
from product_quiz
group by
    case
        when price between 0 and 9999 then 0
        when price between 10000 and 19999 then 10000
        when price between 20000 and 29999 then 20000
        when price between 30000 and 39999 then 30000
    end
order by price_group
;













2-3) 가격대를 뽑을 때 만원대 숫자 활용

select 
    price,
    price/10000,
    trunc(price/10000),
    trunc(price, -4)
from product_quiz;

select 
    price,
    price/10000,
    trunc(price/10000),
    trunc(price/10000)*10000,
    trunc(price, -4)
from product_quiz;

select * from product_quiz;


select 
      trunc(price / 10000) * 10000 as price_group,
      count(*) as products
from product_quiz
group by trunc(price / 10000) * 10000
order by price_group;



select price_code, count(*)
from (
    select 
        product_id,
        product_code,
        price,
        trunc(price / 10000) price_code
    from product_quiz   
)
group by price_code;


select price_code*10000 price_group, count(*) products
from (
    select 
        product_id,
        product_code,
        price,
        trunc(price / 10000) price_code
    from product_quiz   
)
group by price_code;


select price_group, count(*) products
from (
    select 
        trunc(price, -4) price_group
    from product_quiz   
)
group by price_group
order by 1;

