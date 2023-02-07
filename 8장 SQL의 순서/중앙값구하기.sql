-- 고전적인 집합 지향적 방법
SELECT AVG(weight)
FROM (SELECT w1.weight
    FROM Weights w1, Weights w2
    GROUP BY w1.weight 
    HAVING SUM(CASE WHEN w2.weight >= w1.weight THEN 1 ELSE 0 END) 
                >= COUNT(*)/2
        AND SUM(CASE WHEN w2.weight <= w1.weight THEN 1 ELSE 0 END) 
                >= COUNT(*)/2 );
-- 스캔 2회, 결합 1회

-- 절차 지향적 방법 1
SELECT AVG(weight) AS median
FROM (SELECT weight, 
        ROW_NUMBER() OVER (ORDER BY weight ASC, student_id ASC) AS hi,
        ROW_NUMBER() OVER (ORDER BY weight DESC, student_id DESC) AS lo
    FROM Weights) Tmp
WHERE hi IN (lo, lo+1, lo-1);
-- 스캔 1회, 정렬 2회, 결합 0회 

-- 절차 지향적 방법 2
SELECT AVG(weight) 
FROM (SELECT weight,
            2 * ROW_NUMBER() OVER (ORDER BY weight)
                - COUNT(*) OVER() AS diff
    FROM Weights) Tmp
WHERE diff BETWEEN 0 AND 2;
-- 스캔 1회, 정렬 1회, 결합 0회 : SQL 표준으로 중앙값을 구하는 가장 빠른 쿼리
-- 수학적