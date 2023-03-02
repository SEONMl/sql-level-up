-- 1. 외부 설정으로 처리 (UI 설계로 처리)
-- 외부 설정을 사용한 대처 방법의 주의점
--  성능과 사용성의 적절한 트레이드오프 타협점을 찾아야 함
--  애플리케이션 엔지니어와의 커뮤니케이션, 사용자와 합의

-- 2. 데이터 마트로 대처
-- 특정한 쿼리군에서 필요한 데이터만을 저장하는 상대적으로 작은 크기의 테이블을 의미
-- 데이터 신선도: 데이터 갱신 주기, 잦은 갱신 시 성능 문제 야기
-- 데이터 마트 크기: 테이블 크기를 작게 해 I/O 양을 줄이는 것, 크기를 딱히 줄일 수 없다면 효율적이지 않다.
-- 데이터 마트 수: 데이터 마트에 지나치게 의존하지 말 것
-- 배치 윈도우

-- 3. 인덱스 온리 스캔으로 대처
SELECT order_id, receive_date
FROM Orders;
-- 에서 인댁스 온리 스캔으로 바꾸기 위해 의도적으로 커버링 인덱스를 생성한다.
CREATE INDEX CoveringIndex ON Orders (order_id, receive_date);

-- 인덱스 사용하지 못하는 경우 1
SELECT order_id, receive_date
FROM Orders 
WHERE process_flg='5';

CREATE INDEX CoveringIndex_1 ON Orders (process_flg, order_id, receive_date);

-- 인덱스 사용하지 못하는 경우 2
SELECT order_id, receive_date
FROM Orders 
WHERE shop_name = "%대공원%";

CREATE INDEX CoveringIndex_2 ON Orders (shop_name, order_id, receive_date);

-- *주의 사항*
-- DBMS에 따라 사용할 수 없는 경우도 있다.
-- 한 개의 인덱스에 포함할 수 있는 필드 수가 제한된다.
-- 갱신 오버헤드가 커진다.
-- 정기적인 인덱스 리빌드가 필요하다.
-- SQL 구문에 새로운 필드가 추가된다면 사용할 수 없다.