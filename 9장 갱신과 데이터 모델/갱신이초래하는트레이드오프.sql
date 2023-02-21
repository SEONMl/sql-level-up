-- 주문 테이블의 주문날짜와 주문명세 테이블의 배송예정일의 차이가 3이상인 레코드를 선택
-- SQL을 사용하는 방법
SELECT O.order_id, O.order_name, 
    ORC.delivery_date - O.order_date AS diff_days
FROM Orders ORC
    INNER JOIN OrderReceipts ORC
        ON O.order_id = ORC.order_id
WHERE ORC.delivery_date - O.order_date >= 3;

SELECT O.order_id, MAX(O.order_name), MAX(ORC.delivery_date - O.order_date) AS max_diff_days
FROM Orders O
    INNER JOIN OrderReceipts ORC
        ON O.order_id = ORC.order_id
WHERE ORC.delivery_date - O.order_date >=3
GROUP BY O.order_id;

-- 모델 갱신을 사용하는 방법 
-- SQL에 의지하지 않고 문제를 해결할 가능성이 있다.
-- 문제를 해결하는 수단은 코딩 외에도 다양하다!!!!!!!!
-- 반사적으로 SQL 구문을 생각하는 건 성급한 태도, 방법 하나에 의존하려는 경향이 있다.
-- Orders 테이블에 배송 지연 플래그를 추가