-- UNION을 사용할 수밖에 없는 경우: 여러 테이블에서 검색한 결과를 머지하는 경우
SELECT name,age
FROM Team_A
UNION ALL
SELECT name, age
FROM Team_B;

-- UNION을 사용하는 것이 성능적으로 더 좋은 경우: 인덱스 스캔
-- 테이블의 크기와 레코드 히트율에 따라 답이 달라진다.
-- 테이블이 크고 WHERE 조건(or, in, case)으로 선택되는 레코드의 수가 충분히 작다면 UNION이 더 빠르다.