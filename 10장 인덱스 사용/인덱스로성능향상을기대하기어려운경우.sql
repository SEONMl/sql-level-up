-- 1. 압축 조건이 존재하지 않음
SELECT order_id, receive_date
FROM Orders;


-- 2. 레코드를 제대로 압축하지 못하는 경우
SELECT order_id, receive_date
FROM Orders 
WHERE process_flg='5';
-- flg: 1(200만), 2(100만), ..., 5(8200만) 인 경우
--   레코드를 크게 압축할 수 있는 검색 조건이 필요하다.


-- 3. 인덱스를 사용하지 않는 검색 조건
SELECT order_id, receive_date
FROM Orders 
WHERE shop_name = "%대공원%";
-- 중간 일치, 후방 일치 LIKE 연산자는 인덱스를 사용할 수 없다.

SELECT * 
FROM Orders 
WHERE col_1 * 1.1 > 100;
-- 색인 필드로 연산하는 경우

SELECT *
FROM SomeTable 
WHERE col_1 IS NULL;
-- IS NULL을 사용하는 경우

SELECT *
FROM SomeTable
WHERE col_1 <> 100;
-- 부정형을 사용하는 경우