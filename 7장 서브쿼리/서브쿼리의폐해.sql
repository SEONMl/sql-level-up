-- 1. 서브쿼리는 대부분 일시적인 영역에 확보되므로 오버헤드가 생긴다.
-- 2. 인덱스 또는 제약정보를 가지지 않기 때문에 최적화되지 못한다.
-- 3. 결합을 필여러 하기 때문에 비용이 높고 실행 계획 변동 리스크가 발생한다.
-- 4. 테이블 스캔이 두 번 필요하다.

-- 윈도우 함수로 결합을 제거
SELECT cust_id, seq, price
FROM (SELECT cust_id, seq, price,
            ROW_NUMBER()
            OVER(PARTITION BY cust_id
                 ORDER BY seq) AS row_seq
     FROM Receipts) WORK
WHERE WORK.row_seq = 1;

-- 레코드 간 비교에서도 결합은 불필요
-- 정렬 반복 시간 복잡도 < 결합 반복 시간 복잡도
SELECT cust_id, 
    SUM(CASE WHEN min_seq=1 THEN price ELSE 0 END)
        - SUM(CASE WHEN max_seq=1 THEN price ELSE 0 END) AS diff
FROM (
    SELECT cust_id, price,
        ROW_NUMBER() OVER(PARTITION BY cust_id
                            ORDER BY seq) AS min_seq,
        ROW_NUMBER() OVER(PARTITION BY cust_id
                            ORDER BY seq DESC) AS max_seq
    FROM Receipts
) WORK
WHERE WORK.min_seq = 1 OR WORK.max_seq = 1
GROUP BY cust_id;