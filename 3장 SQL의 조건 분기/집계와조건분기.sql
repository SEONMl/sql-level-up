-- 풀 스캔을 두 번 실행하는 쿼리
SELECT prefecture, SUM(pop_men) AS pop_men, SUM(pop_wom) AS pop_wom
FROM (
    SELECT prefecture, pop AS pop_men, NULL AS pop_wom
    FROM Population
    WHERE sex='1'
    UNION
    SELECT prefecture, NULL AS pop_men, pop AS pop_wom
    FROM Population
    WHERE sex='2') tmp
GROUP BY prefecture;

-- 집계에서도 조건 분기를 사용
SELECT prefecture,
    SUM(CASE WHEN sex='1' THEN pop ELSE 0 END) AS pop_men,
    SUM(CASE WHEN sex='2' THEN pop ELSE 0 END) AS pop_wom,
FROM Population
GROUP BY prefecture;