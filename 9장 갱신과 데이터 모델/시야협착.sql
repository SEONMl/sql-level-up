-- SQL로 해결
SELECT O.order_id, 
    MAX(O.order_name) AS order_name,
    MAX(O.order_date) AS order_date,
    COUNT(*) AS item_count
FROM Orders O
    INNER JOIN OrderReceipts ORC
        ON O.order_id = ORC.order_id
GROUP BY O.order_id;

SELECT O.order_id,
    O.order_name,
    O.order_date,
    COUNT(*) OVER (PARTITION BY O.order_id) AS item_count
FROM Orders O
    INNER JOIN OrderReceipts ORC
        ON O.order_id = ORC.order_id;

-- 모델 갱신을 사용하여 해결
-- Orders 테이블에 상품 수 정보를 추가하여 모델을 갱신