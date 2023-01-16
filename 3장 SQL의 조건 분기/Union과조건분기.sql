SELECT item_name, year, price_tax_ex AS price
FROM Item
WHERE year<=2001
UNION ALL
SELECT item_name, year, price_tax_in AS price 
FROM Item
WHERE year>=2002;
-- 코드가 쓸데 없이 길어지고 메모리 낭비가 심한 쿼리

SELECT item_name, year,
    CASE WHEN year<=2001 THEN price_tax_ex
         WHEN year>2001 THEN price_tax_in END AS price
FROM Item;
-- 위와 같이 간결하게 표현 가능
-- Where 구에서 조건 분기하는 사람은 초보자