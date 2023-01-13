-- View : SELECT 구문을 데이터베이스 안에 저장하는 기능
-- CREATE VIEW [뷰 이름] ([필드1], [필드2], ...)
CREATE VIEW CountAddress (v_address, cnt)
AS
SELECT address, count(*)
FROM Address
GROUP BY address;

-- 사용
SELECT v_address, cnt
FROM CountAddress;