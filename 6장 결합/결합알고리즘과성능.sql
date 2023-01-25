-- Nested Loops(중첩 반복)
-- 1. 결합 대상 테이블애서 레코드를 하나씩 반복해가며 스캔
-- 2. 결합 조건애 맞으면 리턴
-- 3. 이러한 작동을 구동 테이블의 모든 레코드에 반복
-- 내부 테이블이 클 때 성능 저하, 어떤 결합 키에 인덱스를 작성해야 하는지가 중요
-- 작은 구동 테이블과 내부 테이블의 인덱스가 중요!!!

-- Hash
-- 1. 작은 테이블 스캔
-- 2. 결합 키에 해시 함수를 적용해서 해시값으로 반환
-- 3. 다른 테이블 스캔 후 결합 키가 해시 테이블에 존재하는지 확인
-- 메모리 사용률 多, 등치 결합에만 사용

-- Sort Merge
-- 1. 결합 대상 테이블을 결합 키로 정렬
-- 2. 일치하는 결합 키를 찾으면 결합
-- 메모리 소모 多(TEMP 탈락 주의!), 비동치 결합에서도 사용 가능, 정렬에 많은 시간과 리소스 요구할 가능성
-- Nested Loops와 Hash를 우선적으로 고려하자.

-- 의도치 않은 크로스 결합 feat. 삼각결합
SELECT *
FROM Table_A a
     INNER JOIN Table_B b
        ON a.key = b.key
     INNER JOIN Table_C c
        ON a.key = c.key;
-- Nested Loops가 선택될 수도 크로스조인이 선택될 수도 있다.

-- 의도치 않은 크로스 결합을 회피하는 방법
-- 불필요한 결합 조건을 추가하여 옵티마이저를 원하는대로 사용할 수 있게 하자.
SELECT *
FROM Table_A a
     INNER JOIN Table_B b
        ON a.key = b.key
     INNER JOIN Table_C c
        ON a.key = c.key
        AND b.key = c.key;

